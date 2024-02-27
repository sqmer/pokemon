//
//  PokemonStatsMock.swift
//  PokemonTests
//
//  Created by Sqmer FOO on 2/27/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

extension PokemonStats {
    static func mock(
        name: String = "Hp",
        value: String = "65") -> Self {
        
        PokemonStats(name: name,
                     value: value)
    }
}
