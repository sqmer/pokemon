//
//  PokemonFavoriteRepository.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/27/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

protocol PokemonFavoriteRepository {
    @discardableResult
    func postFavoritePokemon(userId: String, pokemonId: String, isFavorite: Bool) async -> Result<String?, Error>
}
