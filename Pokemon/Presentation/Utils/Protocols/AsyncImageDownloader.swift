//
//  AsyncImageDownloader.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/24/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import UIKit

protocol AsyncImageDownloader {
    
    func getImage(from url: String) -> UIImage
}
