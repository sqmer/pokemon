//
//  PokemonDetailsViewModelMock.swift
//  PokemonTests
//
//  Created by Sqmer FOO on 2/27/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

class PokemonDetailsViewModelMock: PokemonDetailsViewModel {

    var audioPlayer: AudioPlayable
    var pokemonDetailsRepository: PokemonDetailRepositories
    var pokemonDetailsViewModelDelegate: PokemonDetailsViewModelDelegate?
    
    init(audioPlayer: AudioPlayable, pokemonDetailsRepository: PokemonDetailRepositories, pokemonDetailsViewModelDelegate: PokemonDetailsViewModelDelegate? = nil) {
        self.audioPlayer = audioPlayer
        self.pokemonDetailsRepository = pokemonDetailsRepository
        self.pokemonDetailsViewModelDelegate = pokemonDetailsViewModelDelegate
    }
    
    func fetchPokemonDetailsRequest() {
        return
    }
    
    func pokemonName() -> String? {
        return "Bulbasaur"
    }
    
    func pokemonTypeAtSlot(slot: Int) -> String? {
        if slot == 1 {
            return "Grass"
        }
        return nil
    }
    
    func pokemonMainImage() -> String? {
        return "Image"
    }
    
    func pokemonColorName() -> String? {
        return "ColorName"
    }
    
    func pokemonHeight() -> String? {
        return "185"
    }
    
    func pokemonStats(at index: Int) -> PokemonStats? {
        return PokemonStats.mock()
    }
    
    func pokemonMove(at index: Int) -> String? {
        if index == 1 {
            return "Razor"
        }
        return nil
    }
    
    func pokemonMovesCount() -> Int? {
        return 3
    }
    
    func pokemonStatsCount() -> Int? {
        return 3
    }
    
    func pokemonWeight() -> String? {
        return "80"
    }
    
    func pokemonCrySound() {
        return
    }
    
    func pokemonIsFavorite() -> Bool {
        return true
    }
    
    func updateFavorite() {
        return
    }
}
