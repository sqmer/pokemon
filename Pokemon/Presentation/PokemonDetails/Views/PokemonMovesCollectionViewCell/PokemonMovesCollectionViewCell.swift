//
//  PokemonMovesCollectionViewCell.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/25/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation
import UIKit

class PokemonMovesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moveLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.layer.cornerRadius = 15
        self.containerView.layer.borderColor = UIColor.lightGray.cgColor
        self.containerView.layer.borderWidth = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.moveLabel.text = nil
    }
    
    func setUpCell(name: String?) {
        self.moveLabel.text = name
    }
}
