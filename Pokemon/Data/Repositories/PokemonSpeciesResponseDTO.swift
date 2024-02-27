//
//  PokemonSpeciesResponseDTO.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/25/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

struct PokemonSpeciesResponseDTO: Codable {
 
    var color: PokemonNameUrlResponseDTO
    
    enum CodingKeys: String, CodingKey {
        case color = "color"
    }
}
