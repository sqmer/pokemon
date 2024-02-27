//
//  UIColorExtension.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/25/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func rgbColor(red: CGFloat,
                        green: CGFloat,
                        blue: CGFloat,
                        alpha: CGFloat = 1) -> UIColor {
        
        return UIColor(red: red/256.0, 
                       green: green/256.0,
                       blue: blue/256.0,
                       alpha: alpha)
    }        
}
