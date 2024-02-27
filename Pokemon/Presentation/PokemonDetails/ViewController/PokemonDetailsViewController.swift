//
//  PokemonDetailsViewController.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/24/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation
import UIKit

class PokemonDetailsViewController: UIViewController, XibInstantiable {
    
    var pokemonId: Int?
    private var pokemonDetailsViewModel: PokemonDetailsViewModel?
    
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var movesCollectionView: UICollectionView!
    @IBOutlet private weak var mainImage: UIImageView!
    
    @IBOutlet private weak var colorLabal: UILabel!
    @IBOutlet private weak var primaryType: UILabel!
    @IBOutlet private weak var secondaryType: UILabel!
    @IBOutlet private weak var screenTitle: UILabel!
    @IBOutlet private weak var heightLabel: UILabel!
    @IBOutlet private weak var weightLabel: UILabel!
    
    @IBOutlet private weak var typesStackView: UIStackView!
    @IBOutlet private weak var statsTableView: UITableView!
    
    @IBOutlet private weak var colorView: UIView!
    @IBOutlet private weak var colorContainerView: UIView!
    @IBOutlet private weak var heightContainerView: UIView!
    @IBOutlet private weak var primaryTypeContainerView: UIView!
    @IBOutlet private weak var secondaryTypeContainerView: UIView!
    @IBOutlet private weak var weightContainerView: UIView!
    
    enum Constants {
        static let borderColorBlack: CGColor = UIColor.black.cgColor
        static let borderColorLightGray: CGColor = UIColor.lightGray.cgColor
        static let borderWidth1: CGFloat = 1
        static let cornerRadius15: CGFloat = 15
        static let favoriteImage: String = "EmptyHeart"
        static let favoriteSelectedImage: String = "BlackHeart"
        static let statsTableRowHeight: CGFloat = 30
    }
    
    init(pokemonDetailRepository: PokemonDetailRepositories) {

        super.init(nibName: Self.defaultFileName,
                   bundle: .main)
        
        self.pokemonDetailsViewModel = DefaultPokemonDetailsViewModel(audioPlayer: MobileVLCKitAudioPlayer(),       
                                                                      favoriteService: FavoriteService(),
                                                                      pokemonDetailRepository: pokemonDetailRepository,
                                                                      pokemonDetailsViewModelDelegate: self)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Lifecycle & Setups
extension PokemonDetailsViewController {
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setUpInterface()                
        Task {
            self.pokemonDetailsViewModel?.fetchPokemonDetailsRequest()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.setUpInterface()
    }
    
    func setUpInterface() {
    
        self.setUpAboutViews()
        self.setUpFavorites()
        self.setupMovesCollectionView()
        self.setupStatsTableView()
        self.setUpTypesView()
    }

    func setUpAboutViews() {
        
        self.colorView.layer.cornerRadius = self.colorView.bounds.size.width / 2.0
        
        self.colorContainerView.layer.cornerRadius = Constants.cornerRadius15
        self.weightContainerView.layer.cornerRadius = Constants.cornerRadius15
        self.heightContainerView.layer.cornerRadius = Constants.cornerRadius15
        self.colorContainerView.layer.borderColor = Constants.borderColorLightGray
        self.weightContainerView.layer.borderColor = Constants.borderColorLightGray
        self.heightContainerView.layer.borderColor = Constants.borderColorLightGray
        self.colorContainerView.layer.borderWidth = Constants.borderWidth1
        self.weightContainerView.layer.borderWidth = Constants.borderWidth1
        self.heightContainerView.layer.borderWidth = Constants.borderWidth1
        self.colorContainerView.isHidden = true
        self.weightContainerView.isHidden = true
        self.heightContainerView.isHidden = true
    }
    
    func setUpFavorites(){
        
        self.favoriteButton.setImage(UIImage.init(named: Constants.favoriteImage), for: .normal)
        self.favoriteButton.setImage(UIImage.init(named: Constants.favoriteSelectedImage), for: .selected)
    }
    
    func setupMovesCollectionView(){
        
        self.movesCollectionView.register(PokemonMovesCollectionViewCell.nib, forCellWithReuseIdentifier: PokemonMovesCollectionViewCell.identifier)
    }
    
    func setupStatsTableView(){
        
        self.statsTableView.register(PokemonStatsTableCell.nib,
                                     forCellReuseIdentifier: PokemonStatsTableCell.identifier)
        self.statsTableView.separatorStyle = .none
        self.statsTableView.isScrollEnabled = false
        //TODO: Grow Tableview to size of content
    }
    
    func setUpTypesView() {
        
        self.primaryTypeContainerView.layer.cornerRadius = Constants.cornerRadius15
        self.secondaryTypeContainerView.layer.cornerRadius = Constants.cornerRadius15
        self.primaryTypeContainerView.layer.borderColor = Constants.borderColorBlack
        self.secondaryTypeContainerView.layer.borderColor = Constants.borderColorBlack
        self.primaryTypeContainerView.layer.borderWidth = Constants.borderWidth1
        self.secondaryTypeContainerView.layer.borderWidth = Constants.borderWidth1
        self.primaryTypeContainerView.isHidden = false
        self.secondaryTypeContainerView.isHidden = true
    }
    
    func updateInterface(){
        
        DispatchQueue.main.async {

            self.screenTitle.text = self.pokemonDetailsViewModel?.pokemonName()
            self.favoriteButton.isSelected = self.pokemonDetailsViewModel?.pokemonIsFavorite() ?? false
            
            self.primaryType.text = self.pokemonDetailsViewModel?.pokemonTypeAtSlot(slot: 1)
            self.primaryTypeContainerView.isHidden = false
            
            let secondaryType = self.pokemonDetailsViewModel?.pokemonTypeAtSlot(slot: 2)
            self.secondaryTypeContainerView.isHidden = secondaryType == nil
            self.secondaryType.text = secondaryType
            
            self.mainImage.getImage(from: self.pokemonDetailsViewModel?.pokemonMainImage())
            
            self.colorLabal.text = self.pokemonDetailsViewModel?.pokemonColorName()
            let colorString = self.pokemonDetailsViewModel?.pokemonColorName()
            self.colorView.backgroundColor = self.colorForString(colorString: colorString)
            self.colorView.layer.borderColor = self.borderColorForString(colorString: colorString)
            self.colorView.layer.borderWidth = Constants.borderWidth1
            self.colorContainerView.isHidden = false
            
            self.weightLabel.text = self.pokemonDetailsViewModel?.pokemonWeight()
            self.weightContainerView.isHidden = false
            self.heightLabel.text = self.pokemonDetailsViewModel?.pokemonHeight()
            self.heightContainerView.isHidden = false
            
            self.statsTableView.reloadData()
            self.movesCollectionView.reloadData()
        }
    }
}

//MARK: - PokemonDetailsViewModelDelegate
extension PokemonDetailsViewController: PokemonDetailsViewModelDelegate {
    
    func didUpdateFavorte(isFavorite: Bool) {
        
        DispatchQueue.main.async {
            self.favoriteButton.isSelected = isFavorite
        }
    }
        
    func getPokemonId() -> Int {
        return self.pokemonId ?? 0
    }
    
    func didFinishLoading() {
        DispatchQueue.main.async {
            self.updateInterface()
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
        }
    }
    
    func didFailLoading() {
        //TODO: Handle Error
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
        }
    }
    
    func didStartLoading() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: self.view)
        }
    }
}

//MARK: - IBActions
extension PokemonDetailsViewController {
    
    @IBAction func favoriteAction() {

        self.pokemonDetailsViewModel?.updateFavorite()
    }
    
    @IBAction func playSound() {

        self.pokemonDetailsViewModel?.pokemonCrySound()
    }
}

//MARK: - UITableViewDataSource
extension PokemonDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonDetailsViewModel?.pokemonStatsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonStatsTableCell.identifier) as! PokemonStatsTableCell
        
        guard let viewModel = self.pokemonDetailsViewModel, let stats = viewModel.pokemonStats(at: indexPath.row) else {
            return UITableViewCell()
        }
                
        cell.setUpCell(name: stats.getNameCapitalized(),
                       value: stats.value,
                       color: self.progressBarColorForString(colorString: viewModel.pokemonColorName()),
                       progress: stats.floatValue())
        return cell
    }
}

//MARK: - UITableViewDelegate
extension PokemonDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.statsTableRowHeight
    }
}

//MARK: - UICollectionViewDataSource
extension PokemonDetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemonDetailsViewModel?.pokemonMovesCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonMovesCollectionViewCell.identifier, for: indexPath) as! PokemonMovesCollectionViewCell

        cell.setUpCell(name: self.pokemonDetailsViewModel?.pokemonMove(at: indexPath.row))
        return cell
    }
}

//MARK: - ColorMapper
//TODO: Make Colors Enums
extension PokemonDetailsViewController {
    
    func borderColorForString(colorString: String?) -> CGColor {
        
        guard let colorString else {
            return UIColor.clear.cgColor
        }
        
        switch colorString.lowercased() {

            case "white":
                return UIColor.black.cgColor
            default:
                return UIColor.clear.cgColor
        }
    }
    
    func progressBarColorForString(colorString: String?) -> UIColor {
        
        guard let colorString, colorString.lowercased() != "white" else {
            return UIColor.black
        }
        
        return colorForString(colorString: colorString)
    }

    
    func colorForString(colorString: String?) -> UIColor {
        
        guard let colorString else {
            return UIColor.orange
        }
        
        switch colorString.lowercased() {
            
        case "black":
            return UIColor.black
        case "blue":
            return UIColor.blue
        case "brown":
            return UIColor.brown
        case "gray":
            return UIColor.gray
        case "green":
            return UIColor.rgbColor(red: 75.0, green: 139.0, blue: 116.0)
        case "pink":
            return UIColor.systemPink
        case "purple":
            return UIColor.purple
        case "red":
            return UIColor.red
        case "white":
            return UIColor.white
        case "yellow":
            return UIColor.rgbColor(red: 204, green: 185.0, blue: 116)
        default:
            return UIColor.magenta
        }
    }
}
