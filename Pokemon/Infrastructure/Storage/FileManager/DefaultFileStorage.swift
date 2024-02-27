//
//  DefaultFileStorage.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/26/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

final class DefaultFileStorage: FileStorageProtocol {
            
    func generateUniquePath(for id: String,
                                fileExtension: String) -> URL {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFileName = id + fileExtension
        let fileURL = documentsDirectory.appendingPathComponent(audioFileName)
        return fileURL
    }
    
    func hasFile(fileId: String,
                 fileExtension: String) -> Bool {

        let filePath = self.generateUniquePath(for: fileId,
                                              fileExtension: fileExtension).path
        return FileManager.default.fileExists(atPath: filePath)
    }
    
    func getFile(for id: String,
                 fileExtension: String) -> URL? {
        
        guard self.hasFile(fileId: id, fileExtension: fileExtension) else {
            return nil
        }
        
        let fileURL = self.generateUniquePath(for: id,
                                              fileExtension: fileExtension)
        return fileURL
    }
    
    func saveFile(fileData: Data, 
                  id: String,
                  fileExtension: String) -> URL? {
        
        let fileURL = self.generateUniquePath(for: id,
                                              fileExtension: fileExtension)
        do {
            try fileData.write(to: fileURL)
            return fileURL
        } catch {
            //TODO: Handle Error
            return nil
        }
    }
}
