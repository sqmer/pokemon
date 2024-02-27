//
//  PokemonTypeMock.swift
//  PokemonTests
//
//  Created by Sqmer FOO on 2/27/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

extension PokemonType {
    static func mock(
        name: String = "Grass",
        slot: Int = 0) -> Self {
        
        PokemonType(name: name,
                    slot: slot)
    }
}
