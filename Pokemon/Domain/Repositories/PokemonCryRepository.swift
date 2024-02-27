//
//  PokemonCryRepository.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/26/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

protocol PokemonCryRepository {
    
    func fetchPokemonCry(from url: String) async -> Result<Data, Error>
}
