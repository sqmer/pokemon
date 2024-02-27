//
//  KingFisherImageViewExtension.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/24/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    
    func getImage(from urlString: String?) {
        
        guard let urlString else {
            return
        }
        
        let url = URL(string: urlString)
        self.kf.setImage(with: url)
    }
}
