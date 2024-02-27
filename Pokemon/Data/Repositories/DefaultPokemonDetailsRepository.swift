//
//  DefaultPokemonDetailsRepository.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/25/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

final class DefaultPokemonDetailsRepository {
    
    private let dataTransferLayer: DataTransferLayer
    
    init(dataTransferLayer: DataTransferLayer) {
        self.dataTransferLayer = dataTransferLayer
    }
}

extension DefaultPokemonDetailsRepository: PokemonDetailRepository {
    
    func fetchPokemonDetails(from id: String) async -> Result<PokemonModel, Error> {
        
        let requestDTO = PokemonDetailRequestDTO(id: id)
        let endpoint = PokemonApiEndpoints.getPokemonDetails(with: requestDTO)
        let response = await self.dataTransferLayer.request(with: endpoint)
        switch response {
        
        case .success(let pokemonResponseDto):
            
            let speciesUrl = pokemonResponseDto.species.url
            let speciesResponse = await self.fetchPokemonSpecies(from: speciesUrl)
            
            switch speciesResponse {
            
            case .success(let species):
                let pokemon = pokemonResponseDto.toDomain(color: species.color.name)
                return .success(pokemon)
                
            case .failure(let error):
                return .failure(error)
            }
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func fetchPokemonSpecies(from urlString: String) async -> Result<PokemonSpeciesResponseDTO, Error> {
        
        let endpoint: Endpoint<PokemonSpeciesResponseDTO> = PokemonApiEndpoints.getGenericEndpoint(urlString: urlString,
                                                              isFullPath: true)
        let response = await self.dataTransferLayer.request(with: endpoint)
        
        switch response {

        case .success(let pokemonSpecies):
            return .success(pokemonSpecies)
            
        case .failure(let error):
            return .failure(error)
        }
    }
}

extension DefaultPokemonDetailsRepository: PokemonCryRepository {
    
    func fetchPokemonCry(from url: String) async -> Result<Data, Error> {
                
        let endpoint: Endpoint<Data> = PokemonApiEndpoints.getGenericEndpoint(urlString: url,
                                                                              isFullPath: true,
                                                                              responseDecoder: RawDataResponseDecoder())
        let response = await self.dataTransferLayer.request(with: endpoint)
        
        switch response {
            
            case .success(let data):
                return .success(data)
            case .failure(let error):
                return .failure(error)
        }
    }
}

extension DefaultPokemonDetailsRepository: PokemonFavoriteRepository {
    
    func postFavoritePokemon(userId: String, pokemonId: String, isFavorite: Bool) async -> Result<String?, Error> {
        
        let endpoint = PokemonApiEndpoints.postFavoritePokemon(userId: userId,
                                                              pokemonId: pokemonId,
                                                              isFavorite: isFavorite)
        
        let response = await self.dataTransferLayer.request(with: endpoint)
        switch response {
                        
            case .success(let responseData):
                let responseText = String(data: responseData, encoding: .utf8)
                return .success(responseText)
            case .failure(let error):
                return .failure(error)
        }
    }
}
