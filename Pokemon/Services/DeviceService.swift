//
//  DeviceService.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/27/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

class DeviceService {
    
    static let shared = DeviceService()
    
    func getDeviceId() -> String {
        
        if let deviceId = KeychainService.shared.getDeviceIdFromKeychain() {
            return deviceId
        }
        
        let identifier = UUID()
        KeychainService.shared.setDeviceIdFromKeychain(deviceId: identifier.uuidString)
        return identifier.uuidString
    }
}
