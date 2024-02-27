//
//  DataTransferLayer.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/24/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
}

protocol DataTransferLayer {
    
    typealias CompletionHandler<T> = Result<T, DataTransferError>
    
    func request<T: Decodable, E: ResponseRequestable> (
        with endpoint: E) async -> CompletionHandler<T> where E.Response == T
}


protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

//MARK - Implementation

final class DefaultDataTransferLayer {
    
    private let networkService: NetworkService
    
    init(with networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension DefaultDataTransferLayer: DataTransferLayer {
    
    func request<T, E>(with endpoint: E) async -> CompletionHandler<T> where T : Decodable, T == E.Response, E : ResponseRequestable {
        
        let result = await networkService.request(endpoint: endpoint)
        switch result {
        
        case .success(let data):
            let decodedResult: Result<T, DataTransferError> = self.decode(data: data, decoder: endpoint.responseDecoder)
            return decodedResult
        
        case .failure(let error):
            return .failure(.networkFailure(error))
        }
    }
    
    // MARK: - Private
    private func decode<T: Decodable>(
        data: Data?,
        decoder: ResponseDecoder
    ) -> Result<T, DataTransferError> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            return .failure(.parsing(error))
        }
    }

}

// MARK: - Response Decoders
class JSONResponseDecoder: ResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    init() { }
    func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}

class RawDataResponseDecoder: ResponseDecoder {
    
    init() { }
    
    enum CodingKeys: String, CodingKey {
        case `default` = ""
    }
    func decode<T: Decodable>(_ data: Data) throws -> T {
        if T.self is Data.Type, let data = data as? T {
            return data
        } else {
            let context = DecodingError.Context(
                codingPath: [CodingKeys.default],
                debugDescription: "Expected Data type"
            )
            throw Swift.DecodingError.typeMismatch(T.self, context)
        }
    }
}
