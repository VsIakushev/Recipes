//
//  FavoritesSingletone.swift
//  Recipes
//
//  Created by Vermut xxx on 10.03.2024.
//

import Foundation

class FavoritesSingletone {
    static let shared = FavoritesSingletone()
    
    private var favoritesList: [String: Recipe] = [:]
    
    private init() {}
    
    
    func addRecipeToFavorites(_ recipe: Recipe) {
            favoritesList[recipe.image] = recipe
        print("\n\n\n\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \(favoritesList)\n\n\n\n")

        }

}
