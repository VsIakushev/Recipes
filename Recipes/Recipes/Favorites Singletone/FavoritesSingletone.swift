//
//  FavoritesSingletone.swift
//  Recipes
//
//  Created by Vermut xxx on 10.03.2024.
//

import Foundation

class FavoritesSingletone {
    static let shared = FavoritesSingletone()
    
    var favoritesList: [Recipe] = []
    var recipeFromList: Recipe?
    private init() {}
    
    
    func addRecipeToFavorites(_ recipe: Recipe) {
        guard !favoritesList.contains(recipe) else {
            return
        }
        
        favoritesList.append(recipe)
    }
    
        func getRecipeFromList(_ recipe: Recipe) {
            recipeFromList = recipe
        }
    }
