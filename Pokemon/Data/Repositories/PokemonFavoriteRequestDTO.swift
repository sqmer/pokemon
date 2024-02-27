//
//  PokemonFavoriteRequestDto.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/27/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation


struct PokemonFavoriteRequestDTO: Encodable {
    
    let isFavorite: Bool
    let pokemonId: String
    let userId: String
}
