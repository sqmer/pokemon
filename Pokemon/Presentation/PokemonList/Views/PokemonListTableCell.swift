//
//  PokemonListTableCell.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/24/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import UIKit

class PokemonListTableCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pokemonImageView.contentMode = .scaleAspectFit
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.pokemonName.text = nil
        self.pokemonImageView.image = nil
    }
    
    func setUpCell(title: String?, imageUrl: String?){
        
        self.pokemonName.text = title
        
        if let imageUrl {
            self.pokemonImageView.getImage(from: imageUrl)
        }

        self.accessoryType = .disclosureIndicator
    }
}
