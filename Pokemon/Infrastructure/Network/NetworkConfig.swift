//
//  NetworkConfig.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/24/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

protocol NetworkConfigurable {
    
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
}

struct ApiDataNetworkConfig: NetworkConfigurable {
    
    let baseURL: URL
    let headers: [String: String]
    let queryParameters: [String: String]
    
     init(baseURL: URL,
          headers: [String: String] = [:],
          queryParameters: [String: String] = [:]) {

         self.baseURL = baseURL
         self.headers = headers
         self.queryParameters = queryParameters
    }
}
