//
//  PokemonListResponseDTO.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/24/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

struct PokemonListResponseDTO: Codable {
    
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonNameUrlResponseDTO]
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
    }
}
