//
//  PokemonStatsTableCell.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/25/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation
import UIKit

class PokemonStatsTableCell: UITableViewCell {
    
    @IBOutlet weak var statNameLabel: UILabel!
    @IBOutlet weak var statBar: UIProgressView!
    @IBOutlet weak var statValueLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()      
        
        self.statBar.progressViewStyle = .default
        self.statBar.trackTintColor = .lightGray
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.statNameLabel.text = nil
        self.statValueLabel.text = nil
        self.statBar.progress = 0
    }
    
    func setUpCell(name: String?,
                   value: String?, 
                   color: UIColor,
                   progress: Float){
        
        self.statNameLabel.text = name
        self.statValueLabel.text = value
        self.statBar.progressTintColor = color
        self.statBar.setProgress(progress, animated: false)
    }
}
