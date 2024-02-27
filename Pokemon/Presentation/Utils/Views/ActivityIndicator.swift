//
//  ActivityIndicator.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/27/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import UIKit

class ActivityIndicator {
    
    static let sharedIndicator = ActivityIndicator()
    private var spinnerView = UIView()
    
    func displayActivityIndicator(onView : UIView) {
        spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        
        DispatchQueue.main.async { [weak self] in
            guard let this = self else { return }
            this.spinnerView.addSubview(activityIndicator)
            onView.addSubview(this.spinnerView)
        }
        
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {[weak self] in
            guard let this = self else { return }
            this.spinnerView.removeFromSuperview()
        }
    }
}
