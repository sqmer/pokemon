//
//  PokemonDetailsViewModelTest.swift
//  PokemonTests
//
//  Created by Sqmer FOO on 2/27/24.
//  Copyright © 2024 Sq. All rights reserved.
//

import Foundation
import XCTest

class PokemonDetailsViewModelTest: XCTestCase {
    
    var pokemonDetailsViewModel: PokemonDetailsViewModel?
 
    override func setUp() {
        super.setUp()
        self.pokemonDetailsViewModel = PokemonDetailsViewModelMock(audioPlayer: AudioPlayableMock(),
                                                                   pokemonDetailsRepository: PokemonDetailRepositoriesMock())
    }
    
    func test_PokemonName() {
        XCTAssertEqual(self.pokemonDetailsViewModel?.pokemonName(), "Bulbasaur")
    }
    
    func test_pokemoneType() {
        XCTAssertEqual(self.pokemonDetailsViewModel?.pokemonTypeAtSlot(slot: 1), "Grass")
        XCTAssertNil(self.pokemonDetailsViewModel?.pokemonTypeAtSlot(slot: 2))
    }
    
    func test_mainImage() {
        XCTAssertEqual(self.pokemonDetailsViewModel?.pokemonMainImage(), "Image")
    }
    
    func test_color() {
        XCTAssertEqual(self.pokemonDetailsViewModel?.pokemonColorName(), "ColorName")
    }
    
    func test_height() {
        XCTAssertEqual(self.pokemonDetailsViewModel?.pokemonHeight(), "185")
    }
    
    func test_move() {
        XCTAssertEqual(self.pokemonDetailsViewModel?.pokemonMove(at: 1), "Razor")
        XCTAssertNil(self.pokemonDetailsViewModel?.pokemonMove(at: 2))
    }
    
    func test_move_count() {
        XCTAssertEqual(self.pokemonDetailsViewModel?.pokemonMovesCount(), 3)
    }
    
    func test_stat_count() {
        XCTAssertEqual(self.pokemonDetailsViewModel?.pokemonStatsCount(), 3)
    }
    
    func test_weight() {
        XCTAssertEqual(self.pokemonDetailsViewModel?.pokemonWeight(), "80")
    }
    
    func test_isFavorite() throws {
        
        do {
            let isFavorite = try XCTUnwrap(self.pokemonDetailsViewModel?.pokemonIsFavorite())
            XCTAssertTrue(isFavorite)
        }
        catch let error {
            throw error
        }
    }
    
    func test_stat() {
        
        XCTAssertEqual(self.pokemonDetailsViewModel?.pokemonStats(at: 0)?.name, "Hp")
        XCTAssertEqual(self.pokemonDetailsViewModel?.pokemonStats(at: 0)?.value, "65")
        
    }
    
    override func tearDown() {
        super.tearDown()
        self.pokemonDetailsViewModel = nil
    }
}
