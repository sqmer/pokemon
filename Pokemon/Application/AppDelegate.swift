//
//  AppDelegate.swift
//  Pokemon
//
//  Created by Sqmer FOO on 2/24/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
                    
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = setUpApplicationFlow()
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func setUpApplicationFlow() -> UINavigationController {
        
        let pokemonListRepo = DefaultPokemonListRepository(dataTransferLayer: AppConfiguration.shared.dataTransferLayer)
        let listViewController = PokemonListViewController.init(pokemonListRepository: pokemonListRepo)
        return UINavigationController(rootViewController: listViewController)
    }
}
