//
//  PokemonDetailRepositoriesMock.swift
//  PokemonTests
//
//  Created by Sqmer FOO on 2/27/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

class PokemonDetailRepositoriesMock: PokemonDetailRepositories {
    
    func fetchPokemonCry(from url: String) async -> Result<Data, Error> {
        return .success(Data())
    }
    
    func fetchPokemonDetails(from urlStringOrId: String) async -> Result<PokemonModel, Error> {
        return .success(PokemonModel.mock())
    }
    
    func postFavoritePokemon(userId: String, pokemonId: String, isFavorite: Bool) async -> Result<String?, Error> {
        return .success(nil)
    }
}
