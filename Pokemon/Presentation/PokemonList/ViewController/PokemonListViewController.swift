//
//  ViewController.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/24/24.
//

import UIKit

final class PokemonListViewController: UIViewController, XibInstantiable {
    
    @IBOutlet private weak var tableView: UITableView!
    
    //TODO: Keep force unwrapped ?
    private var pokemonListViewModel: PokemonListViewModel!
    
    init(pokemonListRepository: PokemonListRepository) {
                
        super.init(nibName: Self.defaultFileName,
                   bundle: .main)
        //TODO: - Get rid of self
        self.pokemonListViewModel = DefaultPokemonListViewModel(pokemonListRepository: pokemonListRepository,
                                                                pokemonListViewModelDelegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Lifecycle & Setups
extension PokemonListViewController {
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.setUpInterface()
        Task {
            self.pokemonListViewModel.fetchPokemonListRequest()
        }
    }
    
    func setUpInterface() {
        self.setupTableView()
    }
    
    func setupTableView(){
        
        self.tableView.register(PokemonListTableCell.nib, 
                                forCellReuseIdentifier: PokemonListTableCell.identifier)
        self.tableView.register(LoadMoreTableCell.nib,
                                forCellReuseIdentifier: LoadMoreTableCell.identifier)
        self.tableView.separatorStyle = .none
    }
}

//MARK: - UITableViewDataSource
extension PokemonListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? self.pokemonListViewModel.pokemonCount : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            return pokemonCellForIndexPath(indexPath: indexPath)
        }
        else {
            return loadMoreCell()
        }
    }
    
    func pokemonCellForIndexPath(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListTableCell.identifier) as! PokemonListTableCell
        guard let pokemon = self.pokemonListViewModel.pokemonAtIndex(index: indexPath.row) else {
            return UITableViewCell()
        }
        cell.setUpCell(title: pokemon.nameCapitalized(), imageUrl: pokemon.mainImage)
        return cell
    }
    
    func loadMoreCell() -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LoadMoreTableCell.identifier) as! LoadMoreTableCell
        cell.startLoading()
        cell.selectionStyle = .none
        self.pokemonListViewModel.fetchNextPokemonListRequest()
        return cell
    }
}

//MARK: - UITableViewDelegate
extension PokemonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        //TODO: Replace with Router
        let pokemonDetailsRepository = DefaultPokemonDetailsRepository(dataTransferLayer: AppConfiguration.shared.dataTransferLayer)
        let vc = PokemonDetailsViewController.init(pokemonDetailRepository: pokemonDetailsRepository)
        guard let pokemonId = self.pokemonListViewModel.pokemonAtIndex(index: indexPath.row)?.id else {
            return
        }
        vc.pokemonId = pokemonId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - PokemonListViewModelDelegate
extension PokemonListViewController: PokemonListViewModelDelegate {

    func didFinishLoading() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.hideActivityIndicator()
            self.tableView.reloadData()
        }
    }
    
    func didFailLoading() {
        //TODO: Show Empty View Error
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: self.view)
        }
    }
    
    func didStartLoading() {
        DispatchQueue.main.async {
            ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: self.view)
        }
    }
}

