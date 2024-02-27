//
//  KeychainService.swift
//  InABox
//
//  Created by Sqmer FOO on 11/20/19.
//  Copyright © 2024 Sqmer All rights reserved.
//

import Foundation

class KeychainService {
    
    enum KeychainKey : String {
        case KeychainKeyDeviceId = "KeychainKeyDeviceId"
    }
    
    static let shared = KeychainService()
    
    private init(){}
    
    func getDeviceIdFromKeychain() -> String? {
        do {
            let passwordItems = try KeychainPasswordItem.passwordItems(forService: KeychainConfiguration.serviceName, accessGroup: nil)
            
            for passwordItem in passwordItems {
                if (passwordItem.account == KeychainKey.KeychainKeyDeviceId.rawValue) {
                    do {
                        let password = try passwordItem.readPassword()
                        return password
                    }
                    catch {
                        return nil
                    }
                }
            }
            return nil

        }
        catch {
            return nil
        }
    }
    
    func setDeviceIdFromKeychain(deviceId:String){
    
        do {
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: KeychainKey.KeychainKeyDeviceId.rawValue, accessGroup: KeychainConfiguration.accessGroup)
            try passwordItem.savePassword(deviceId)
        }
        catch {
        }
    }
    
    func removeDeviceIdFromKeychain(){
        do {
            var passwordItems = try KeychainPasswordItem.passwordItems(forService: KeychainConfiguration.serviceName, accessGroup: nil)            
            passwordItems.removeAll(where: { (passwordItem) -> Bool in
                return passwordItem.account == KeychainKey.KeychainKeyDeviceId.rawValue
            })
        }
        catch {
        }
    }
}
