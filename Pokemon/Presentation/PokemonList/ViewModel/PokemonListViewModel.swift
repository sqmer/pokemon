//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/24/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation

protocol PokemonListViewModel {
    
    var pokemonCount: Int { get }
    var pokemonListRepository: PokemonListRepository { get }
    var pokemonListViewModelDelegate: PokemonListViewModelDelegate? { get }
    
    func fetchPokemonListRequest()
    func fetchNextPokemonListRequest()
    func pokemonAtIndex(index: Int) -> PokemonModel?
}

protocol PokemonListViewModelDelegate: AnyObject {

    func didStartLoading()
    func didFinishLoading()
    func didFailLoading()
}

final class DefaultPokemonListViewModel: PokemonListViewModel {
    
    internal var isLoadingMore: Bool = false
    internal var nextUrl: String?
    internal var pokemonList: [PokemonModel] = [PokemonModel]()
    
    internal let pokemonListRepository: PokemonListRepository
    weak var pokemonListViewModelDelegate: PokemonListViewModelDelegate?
    
    
    init(pokemonListRepository: PokemonListRepository,
         pokemonListViewModelDelegate: PokemonListViewModelDelegate? = nil) {
        
        self.pokemonListRepository = pokemonListRepository
        self.pokemonListViewModelDelegate = pokemonListViewModelDelegate
    }
}

// MARK: - PokemonListViewModel
extension DefaultPokemonListViewModel {
    
    func fetchPokemonListRequest(urlString: String? = nil) {
                
        Task {
            
            if (!isLoadingMore){
                self.pokemonListViewModelDelegate?.didStartLoading()
            }
            
            let result = await self.pokemonListRepository.fetchPokemonList(urlString: urlString)
            
            switch result {
                
            case .success((let list, let nextUrl)):
                self.nextUrl = nextUrl
                self.pokemonList.append(contentsOf: list.sorted(by: { $0.id < $1.id }))
                self.pokemonListViewModelDelegate?.didFinishLoading()

            case .failure(_):
                self.pokemonListViewModelDelegate?.didFailLoading()
            }
        }
    }
    
    func fetchPokemonListRequest() {
        self.fetchPokemonListRequest(urlString: nil)
    }
    
    func fetchNextPokemonListRequest() {
        isLoadingMore = true
        guard let next = self.nextUrl else {
            return
        }
        self.fetchPokemonListRequest(urlString: next)
    }
        
    func pokemonAtIndex(index: Int) -> PokemonModel? {
        
        return self.pokemonList[index]
    }
    
    var pokemonCount: Int {
        self.pokemonList.count
    }
}
