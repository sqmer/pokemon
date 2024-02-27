//
//  PokemonListRepository.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/24/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

final class DefaultPokemonListRepository {
    
    private let dataTransferLayer: DataTransferLayer
    
    init(dataTransferLayer: DataTransferLayer) {
        self.dataTransferLayer = dataTransferLayer
    }
}

extension DefaultPokemonListRepository: PokemonListRepository {
    
    func fetchPokemonList(urlString: String? = nil) async -> Result<([PokemonModel], String?), Error> {
                
        let listOfPokemonDTOs = await self.fetchPokemonListRequest(urlString: urlString)

        switch listOfPokemonDTOs {
        
        case .success(let pokemonListDTO):
            let listOfPokemonsDetailsUrls = pokemonListDTO.results.map { $0.url }
            let pokemonListResponse = await self.fetchPokemonListDetailsRequest(for: listOfPokemonsDetailsUrls)
            let pokemonList = pokemonListResponse.map({ $0.toDomain() })
            return .success((pokemonList, pokemonListDTO.next))
            
        case .failure(let error):
            return .failure(error)
        }
    }
}

//MARK: - PokemonDetailRepository
extension DefaultPokemonListRepository: PokemonDetailRepository {
    
    func fetchPokemonDetails(from urlString: String) async -> Result<PokemonModel, Error> {

        let endpoint = await fetchPokemonDetailsRequest(from: urlString)

        switch endpoint {
                    
        case .success(let pokemoneResposneDTO):
            return .success(pokemoneResposneDTO.toDomain())
            
        case .failure(let error):
            return .failure(error)
        }
    }
}

//Mark: - Private
extension DefaultPokemonListRepository {
        
    private func fetchPokemonListRequest(urlString: String?) async -> Result<PokemonListResponseDTO, Error> {
        
        let endpoint: Endpoint<PokemonListResponseDTO>
        if let urlString {
            endpoint = PokemonApiEndpoints.getPokemonListFullPath(urlString: urlString)
        }
        else {
            endpoint = PokemonApiEndpoints.getPokemonList()
        }
                            
        let response = await self.dataTransferLayer.request(with: endpoint)        
        switch response {
        
        case .success(let responseDTO):
            return .success(responseDTO)
            
        case .failure(let error):
            return .failure(error)
    
        }
    }
    
    private func fetchPokemonListDetailsRequest(for urls: [String]) async -> [PokemonResponseDTO] {
        
        let pokemons = await withTaskGroup(of: Result<PokemonResponseDTO, Error>.self,
                                           returning: [PokemonResponseDTO].self) { taskGroup in
                        
            for url in urls {
                taskGroup.addTask { await self.fetchPokemonDetailsRequest(from: url) }
            }

            var pokemons = [PokemonResponseDTO]()
            for await result in taskGroup {
                switch result {
                                
                case .success(let pokemon):
                    pokemons.append(pokemon)
                    
                //TODO: Handle Error
                case .failure(let error):
                    print("Handle Error \(error)")
                }
            }
            return pokemons
        }
        return pokemons
    }
        
    private func fetchPokemonDetailsRequest(from urlString: String) async -> Result<PokemonResponseDTO, Error>  {

        let endpoint: Endpoint<PokemonResponseDTO> = PokemonApiEndpoints.getGenericEndpoint(urlString: urlString,
                                                                                            isFullPath: true)
        let response = await self.dataTransferLayer.request(with: endpoint)
        switch response {
                    
        case .success(let pokemon):
            return .success(pokemon)
            
        case .failure(let error):
            return .failure(error)
        }        
    }
}
