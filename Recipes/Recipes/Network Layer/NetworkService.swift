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
        
        
//        if let url = URL(string: "https://api.edamam.com/api/recipes/v2") {
        if let url = URL(string: "https://api.edamam.com/api/recipes/v2?type=public&app_id=eb15e1ec&app_key=41b2ee9152e7908a48d4dffdd80361ea&dishType=Soup") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("error in request")
                } else {
                    if let resp = response as? HTTPURLResponse,
                       resp.statusCode == 200,
                       let responseData = data {
                        
                        do {
                            let data = try
                            JSONDecoder().decode(ResponseDTO.self, from: responseData)
                            print("recipe name", data.hits[0].recipe.label)
                            print("recipe quantity", data.hits.count)
                            // array recipes = .map
//                            var recipes: [RecipeDTO] = []
//                            for hit in data.hits {
//                                recipes.append(hit.recipe)
//                            }
                            
                            let recipes = data.hits.map { RecipeNetwork(dto: $0.recipe)}
//                            let result: Result<[RecipeNetwork], Error> = .success(recipes)
                            completion(.success(recipes))

                        } catch {
                            print(error)
                        }
                        
                        
                    }
                }
            }.resume()
        }
    }
}
