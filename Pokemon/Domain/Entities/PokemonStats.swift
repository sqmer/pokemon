//
//  PokemonStats.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/25/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

struct PokemonStats {
    
    let name: String
    let value: String
    
    //TODO: - Move to Presentation Layer
    func floatValue() -> Float {
        return (Float(value) ?? 0)/255.0
    }
    
    //TODO: - Move to Presentation Layer
    func getNameCapitalized() -> String {
        return self.name.capitalized
    }        
}
