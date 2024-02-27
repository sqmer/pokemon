//
//  PokemonListRepository.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/24/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

protocol PokemonListRepository {

    func fetchPokemonList(urlString: String?) async -> Result<([PokemonModel], String?), Error>
}
