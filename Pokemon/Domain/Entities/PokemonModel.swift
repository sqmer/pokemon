//
//  PokemonModel.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/24/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

struct PokemonModel {
    
    let id: Int

    let color: String?
    let height: String?
    let legacyCryUrl: String?
    let mainImage: String?
    let moves: [String]
    let name: String?
    let stats: [PokemonStats]
    let type: [PokemonType]
    let weight: String?
    
    init(
        id: Int,
        color: String? = nil,
        height: String? = nil,
        legacyCryUrl: String? = nil,
        mainImage: String? = nil,
        moves: [String] = [],
        name: String? = nil,
        stats: [PokemonStats] = [],
        type: [PokemonType] = [],
        weight: String? = nil
    ) {
        
        self.id = id
        self.color = color
        self.height = height
        self.legacyCryUrl = legacyCryUrl
        self.mainImage = mainImage
        self.moves = moves
        self.name = name
        self.stats = stats
        self.type = type
        self.weight = weight
    }
    
    //TODO: - Move to Presentation Layer
    func nameCapitalized() -> String? {
        return self.name?.capitalized
    }
}
