//
//  FileStorageProtocol.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/26/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

protocol FileStorageProtocol {
    
    func hasFile(fileId: String, fileExtension: String) -> Bool
    func getFile(for id: String, fileExtension: String) -> URL?
    func saveFile(fileData: Data, id: String, fileExtension: String) -> URL?
    func generateUniquePath(for id: String, fileExtension: String) -> URL
}
