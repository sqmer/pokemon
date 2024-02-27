//
//  PokemonNameUrlResponseDTO.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/25/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation


struct PokemonNameUrlResponseDTO: Codable {
    
    var name: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
}
