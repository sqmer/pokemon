//
//  PokemonModelMock.swift
//  PokemonTests
//
//  Created by Sqmer FOO on 2/27/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

extension PokemonModel {

    static func mock(
        id: Int = 0,
        color: String? = nil,
        height: String? = nil,
        legacyCryUrl: String? = nil,
        mainImage: String? = nil,
        moves: [String] = [],
        name: String? = nil,
        stats: [PokemonStats] = [],
        type: [PokemonType] = [],
        weight: String? = nil) -> Self {
        
            PokemonModel(
                id: id,
                color: color,
                height: height,
                legacyCryUrl: legacyCryUrl,
                mainImage: mainImage,
                moves: moves,
                name: name,
                stats: stats,
                type: type,
                weight: weight
            )
    }
}

