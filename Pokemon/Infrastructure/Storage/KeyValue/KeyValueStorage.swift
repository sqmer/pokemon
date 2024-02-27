//
//  KeyValueStorage.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/27/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

//TODO: Make Type Agnostic
protocol KeyValueStorage {
    
    func hasItemForKey(key: String) -> Bool
    func setItemForKey(key: String, value: Bool)
}
