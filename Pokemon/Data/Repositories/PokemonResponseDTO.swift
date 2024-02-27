//
//  PokemonResponseDTO.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/24/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

struct PokemonResponseDTO: Codable {
    
    var id: Int
    var cries: PokemonCriesResponseDTO
    var height: Int
    var moves: [PokemonMoveResponseDTO]
    var name: String
    var species: PokemonNameUrlResponseDTO
    var sprites: PokemonSpritesResponseDTO
    var stats: [PokemonStatsResponseDTO]
    var types: [PokemonTypesResponseDTO]
    var weight: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case height = "height"
        case cries  = "cries"
        case moves = "moves"
        case name = "name"
        case species = "species"
        case sprites = "sprites"
        case stats = "stats"
        case types = "types"
        case weight = "weight"
    }
}

struct PokemonCriesResponseDTO: Codable {
    
    var legacy: String
    
    enum CodingKeys: String, CodingKey {
        case legacy = "legacy"
    }
}

struct PokemonMoveResponseDTO: Codable {
    
    var move: PokemonNameUrlResponseDTO
    
    enum CodingKeys: String, CodingKey {
        case move = "move"
    }
}

struct PokemonSpritesResponseDTO: Codable {
    
    var other: PokemonSpritesOthersResponseDTO
    
    enum CodingKeys: String, CodingKey {
        case other = "other"
    }
}

struct PokemonSpritesOthersResponseDTO: Codable {
    
    var officialArtwork: PokemonSpritesOtherOfficialArtworksResponseDTO
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct PokemonSpritesOtherOfficialArtworksResponseDTO: Codable {
    
    var frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct PokemonStatsResponseDTO: Codable {
    
    var baseStat: Int
    var stat: PokemonNameUrlResponseDTO
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat = "stat"
    }
}

struct PokemonTypesResponseDTO: Codable {
    
    var slot: Int
    var type: PokemonNameUrlResponseDTO
    
    enum CodingKeys: String, CodingKey {
        case slot = "slot"
        case type = "type"
    }
}

// MARK: - Mapping to Domain
extension PokemonResponseDTO {
    
    func toDomain(color: String? = nil) -> PokemonModel {
        
        return PokemonModel(
            id: self.id,
            color: color,
            height: String(self.height),
            legacyCryUrl: self.cries.legacy,
            mainImage: self.sprites.other.officialArtwork.frontDefault,
            moves: self.moves.map({ $0.move.name }),
            name: self.name,
            stats: self.stats.map({ $0.toDomain() }),
            type: self.types.map({ $0.toDomain() }),
            weight: String(self.weight)
        )
    }
}

extension PokemonStatsResponseDTO {
    
    func toDomain() -> PokemonStats {
        
        return PokemonStats(name: self.stat.name,
                            value: String(self.baseStat))
    }
}

extension PokemonTypesResponseDTO {
    
    func toDomain() -> PokemonType {
        
        return PokemonType(name: self.type.name,
                           slot: self.slot
        )
    }
}
