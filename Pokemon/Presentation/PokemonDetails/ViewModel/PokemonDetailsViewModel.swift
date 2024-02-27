//
//  PokemonDetailsViewModel.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/25/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

typealias PokemonDetailRepositories = PokemonCryRepository &
PokemonDetailRepository &
PokemonFavoriteRepository

protocol PokemonDetailsViewModel {
    
    var audioPlayer: AudioPlayable { get }
    var pokemonDetailsRepository: PokemonDetailRepositories { get }
    var pokemonDetailsViewModelDelegate: PokemonDetailsViewModelDelegate? { get }
    
    func fetchPokemonDetailsRequest()
    
    func pokemonName() -> String?
    func pokemonTypeAtSlot(slot: Int) -> String?
    func pokemonMainImage() -> String?
    func pokemonColorName() -> String?
    func pokemonHeight() -> String?
    func pokemonMove(at index: Int) -> String?
    func pokemonMovesCount() -> Int?
    func pokemonStats(at index: Int) -> PokemonStats?
    func pokemonStatsCount() -> Int?
    func pokemonWeight() -> String?
    
    func pokemonCrySound() -> Void
    func pokemonIsFavorite() -> Bool
    func updateFavorite() -> Void
}

protocol PokemonDetailsViewModelDelegate: AnyObject {
    
    func getPokemonId() -> Int
    func didStartLoading()
    func didFinishLoading()
    func didFailLoading()
    func didUpdateFavorte(isFavorite: Bool)
}

final class DefaultPokemonDetailsViewModel: PokemonDetailsViewModel {
        
    internal var pokemon: PokemonModel? = nil
    
    internal let audioPlayer: AudioPlayable
    internal let favoriteService: KeyValueStorage
    internal let pokemonDetailsRepository: PokemonDetailRepositories
    internal weak var pokemonDetailsViewModelDelegate: PokemonDetailsViewModelDelegate?
    
    init(audioPlayer: AudioPlayable,
         favoriteService: KeyValueStorage,
         pokemonDetailRepository: PokemonDetailRepositories,
         pokemonDetailsViewModelDelegate: PokemonDetailsViewModelDelegate? = nil) {

        self.audioPlayer = audioPlayer
        self.favoriteService = favoriteService
        self.pokemonDetailsRepository = pokemonDetailRepository
        self.pokemonDetailsViewModelDelegate = pokemonDetailsViewModelDelegate
    }
}

//MARK: - PokemonDetailsViewModel
extension DefaultPokemonDetailsViewModel {
    
    func fetchPokemonDetailsRequest() {
        
        self.pokemonDetailsViewModelDelegate?.didStartLoading()
        Task {
            
            guard let pokemonId = self.pokemonDetailsViewModelDelegate?.getPokemonId() as? Int else {
                return
            }
            
            let result = await self.pokemonDetailsRepository.fetchPokemonDetails(from: String(pokemonId))
            
            switch result {
                
            case .success(let pokemon):
                self.pokemon = pokemon
                self.pokemonDetailsViewModelDelegate?.didFinishLoading()

            case .failure(_):
                self.pokemonDetailsViewModelDelegate?.didFailLoading()
            }
        }
    }
    
    func pokemonName() -> String? {
        return self.pokemon?.name?.capitalized
    }
    
    func pokemonTypeAtSlot(slot: Int) -> String? {
        return self.pokemon?.type.first(where: { $0.slot == slot })?.name.capitalized
    }
    
    func pokemonMainImage() -> String? {
        return self.pokemon?.mainImage
    }
    
    func pokemonCrySound() {
                                
        if let cryPath = self.pokemon?.legacyCryUrl,
            let url = URL(string: cryPath) {
            self.audioPlayer.play(filePath: url)
         }
    }
    
    func pokemonColorName() -> String? {
        return self.pokemon?.color?.capitalized
    }
    
    func pokemonHeight() -> String? {
        return self.pokemon?.height
    }
    
    func pokemonMove(at index: Int) -> String? {
        guard let count = self.pokemonMovesCount(), 
                count > index,
                let move = self.pokemon?.moves[index] else {
            return nil
        }
        return move.capitalized
    }
    
    func pokemonMovesCount() -> Int? {
        return self.pokemon?.moves.count
    }
    
    func pokemonStats(at index: Int) -> PokemonStats? {
        guard let count = self.pokemonStatsCount(),
                count > index,
                let stat = self.pokemon?.stats[index] else {
            return nil
        }
        return stat
    }
    
    func pokemonStatsCount() -> Int? {
        return self.pokemon?.stats.count
    }
    
    func pokemonWeight() -> String? {
        self.pokemon?.weight
    }
    
    func pokemonIsFavorite() -> Bool {
        
        if let pokemon {
            return self.favoriteService.hasItemForKey(key: String(pokemon.id))
        }
                
        return false
    }
    
    func updateFavorite() {
        
        //TODO: Inject DeviceService into ViewModel
        Task {
            let deviceId = DeviceService.shared.getDeviceId()
            if let pokemon = self.pokemon {
                let pokemonId = String(pokemon.id)
                let isFavorite = self.favoriteService.hasItemForKey(key: pokemonId)
                self.favoriteService.setItemForKey(key: pokemonId, value: !isFavorite)
                await self.pokemonDetailsRepository.postFavoritePokemon(userId: deviceId,
                                                                         pokemonId: String(pokemon.id),
                                                                         isFavorite: !isFavorite)
                self.pokemonDetailsViewModelDelegate?.didUpdateFavorte(isFavorite: !isFavorite)
            }
        }
    }
}
