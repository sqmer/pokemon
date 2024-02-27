//
//  PokemonListApiEndpoints.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/24/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

struct PokemonApiEndpoints {
    
    static func getGenericEndpoint<T>(urlString: String,
                                      isFullPath: Bool,
                                      responseDecoder: ResponseDecoder = JSONResponseDecoder()) -> Endpoint<T> {
        return Endpoint(path: urlString,
                        isFullPath: true,
                        responseDecoder: responseDecoder)
    }
    
    static func getPokemonList() -> Endpoint<PokemonListResponseDTO> {
        return Endpoint(path: "pokemon")
    }
    
    static func getPokemonListFullPath(urlString: String) -> Endpoint<PokemonListResponseDTO> {
        return Endpoint(path: urlString, isFullPath: true, hasQueryParams: true)
    }
        
    static func getPokemonDetails(with requestDto: PokemonDetailRequestDTO) -> Endpoint<PokemonResponseDTO> {
        return Endpoint(path: "pokemon/\(requestDto.id)")
    }
    
    static func postFavoritePokemon(userId: String, pokemonId: String, isFavorite: Bool) -> Endpoint<Data> {
        //TODO: Move Path & headers to config file
        let requestDTO = PokemonFavoriteRequestDTO(isFavorite: isFavorite,
                                                   pokemonId: pokemonId,
                                                   userId: userId)
        return Endpoint(path: "https://webhook.site/b099222f-9c03-428c-b5cc-dfa1fadab974",
                        isFullPath: true,
                        method: .post,
                        headerParameters: ["Content-Type":"application/json"],
                        bodyParametersEncodable: requestDTO,
                        bodyEncoder: JSONBodyEncoder(),
                        responseDecoder: RawDataResponseDecoder())
    }
}
