//
//  XibInstantiable.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/26/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation
import UIKit

protocol XibInstantiable: NSObjectProtocol {
    static var defaultFileName: String { get }
}

extension XibInstantiable where Self: UIViewController {
    
    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }        
}

