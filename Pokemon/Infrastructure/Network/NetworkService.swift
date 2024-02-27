//
//  NetworkService.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/25/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case generic(Error)
    case urlRequestError
}

protocol NetworkService {
    
    func request(endpoint: Requestable) async -> Result<Data?, NetworkError>
}

protocol NetworkSessionManager {
     
    func request(_ request: URLRequest) async -> (data: Data?, response: URLResponse?, requestError: Error?)
}

// MARK: - Implementation

final class DefaultNetworkService {
    
    private let config: NetworkConfigurable
    private let sessionManager: NetworkSessionManager
    
    init(config: NetworkConfigurable, 
         sessionManager: NetworkSessionManager = DefaultNetworkSessionManager()) {
        self.config = config
        self.sessionManager = sessionManager
    }
    
    func request(_ request: URLRequest) async -> Result<Data?, NetworkError> {
        
        let sessionDataTask = await sessionManager.request(request)
            
        if let requestError = sessionDataTask.requestError {
            var error: NetworkError
            if let response = sessionDataTask.response as? HTTPURLResponse {
                error = .error(statusCode: response.statusCode, data: sessionDataTask.data)
            } else {
                error = .generic(requestError)
            }
            
            return .failure(error)
        }

        return .success(sessionDataTask.data)
    }
}

extension DefaultNetworkService: NetworkService {
    
    func request(endpoint: Requestable) async -> Result<Data?, NetworkError> {
        do {
            let urlRequest = try endpoint.urlRequest(with: config)
            return await request(urlRequest)
        } catch {
            return .failure(.urlRequestError)
        }
    }
}

final class DefaultNetworkSessionManager: NetworkSessionManager {
    
    func request(_ request: URLRequest) async -> (data: Data?, response: URLResponse?, requestError: Error?) {
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            return (data, response, nil)
        } catch {
            return (nil, nil, error)
        }
    }
}
