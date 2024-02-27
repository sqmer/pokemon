//
//  AppConfigurations.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/25/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

final class AppConfiguration {
    
    public var dataTransferLayer: DataTransferLayer
    
    static var apiBaseURL: String = {
        return "https://pokeapi.co/api/v2/"
    }()
    
    static var defaultDataTransferLayer: DataTransferLayer {
                
        let baseURL = URL(string: AppConfiguration.apiBaseURL)!
        let networkConfig = ApiDataNetworkConfig(baseURL: baseURL)
        let networkService = DefaultNetworkService(config: networkConfig)
        return DefaultDataTransferLayer(with: networkService)
    }
    
    static let shared = AppConfiguration(dataTransferLayer: AppConfiguration.defaultDataTransferLayer)
                    
    init(dataTransferLayer: DataTransferLayer) {
        self.dataTransferLayer = dataTransferLayer
    }
}
