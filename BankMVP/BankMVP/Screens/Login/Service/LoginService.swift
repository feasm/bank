//
//  LoginService.swift
//  BankMVP
//
//  Created by Felipe Melo on 17/06/22.
//  Copyright © 2022 Felipe Melo. All rights reserved.
//

import Foundation

typealias LoginCompletion = (Result<LoginModel, NetworkError>) -> Void

enum NetworkError: Error {
    case badURL
    case serviceInternalError(_ error: Error)
    case noData
    case decodeError(_ error: Error)
}

protocol LoginServiceProtocol {
    func login(endpoint: String, username: String, password: String, _ completion: @escaping LoginCompletion)
}

final class LoginService: LoginServiceProtocol {
    
    let session: URLSession
    var baseUrl = Constants.baseURL
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func login(endpoint: String, username: String, password: String, _ completion: @escaping LoginCompletion) {
        guard let url = URL(string: baseUrl + endpoint) else {
            completion(.failure(.badURL))
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.serviceInternalError(error)))
                }
                
                if let data = data {
                    do {
                        let loginModel = try JSONDecoder().decode([LoginModel].self, from: data)
                        completion(.success(loginModel[0]))
                    } catch let error {
                        completion(.failure(.decodeError(error)))
                    }
                } else {
                    completion(.failure(.noData))
                }
            }
        }.resume()
    }
    
}
