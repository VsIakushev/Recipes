//
//  FavoritesSingletone.swift
//  Recipes
//
//  Created by Vermut xxx on 10.03.2024.
//

import Foundation
/// Синглтон
final class FavoritesSingletone {
    static let shared = FavoritesSingletone()
    /// массив с избранными рецептами
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
