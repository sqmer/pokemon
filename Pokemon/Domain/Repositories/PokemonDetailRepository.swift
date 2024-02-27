//
//  PokemonDetailRepository.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/24/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

protocol PokemonDetailRepository {
    
    func fetchPokemonDetails(from urlStringOrId: String) async -> Result<PokemonModel, Error>
}
