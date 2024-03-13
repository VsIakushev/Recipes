//
//  NetworkService.swift
//  Recipes
//
//  Created by Vermut xxx on 14.03.2024.
//

import Foundation

    /// Протокол NetworkServiceProtocol
    protocol NetworkServiceProtocol {
        /// Получение детального рецепта
        func getRecipeDetail(_ uri: String, completion: @escaping (Result<RecipeNetwork, Error>) -> Void)
        /// Получение рецептов
        func getRecipes(completion: @escaping (Result<[RecipeNetwork], Error>) -> Void)
    }

final class NetworkService: NetworkServiceProtocol {
    func getRecipeDetail(_ uri: String, completion: @escaping (Result<RecipeNetwork, Error>) -> Void) {
        
    }
    
    func getRecipes(completion: @escaping (Result<[RecipeNetwork], Error>) -> Void) {
        if let url = URL(string: "https://api.edamam.com/api/recipes/v2") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("error in request")
                } else {
                    if let resp = response as? HTTPURLResponse,
                       resp.statusCode == 200,
                       let responseData = data {
                        
                        let recipes = try?
                        JSONDecoder().decode([RecipeNetwork].self, from: responseData)
                        print(recipes)
                    }
                }
            }.resume()
        }
    }
    
    
}
