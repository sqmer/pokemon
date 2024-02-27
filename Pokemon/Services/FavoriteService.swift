//
//  FavoriteService.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/27/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

final class FavoriteService: KeyValueStorage {
    
    func hasItemForKey(key: String) -> Bool {
        if let hasFavorite = UserDefaults.standard.value(forKey: key) as? Bool {
            return hasFavorite
        }
        return false
    }
    
    func setItemForKey(key: String, value: Bool) {
        UserDefaults.standard.setValue(true, forKey: key)
    }
}
