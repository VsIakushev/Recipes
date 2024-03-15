// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол NetworkServiceProtocol
protocol NetworkServiceProtocol: AnyObject {
    /// Получение детального рецепта
    func getRecipeDetail(uri: String, completion: @escaping (Result<Recipe, Error>) -> Void)
    /// Получение рецептов
    func getRecipes(dishType: RecipeType, health: String?,
                    query: String?, completion: @escaping (Result<[Recipe], Error>) -> Void)

}

/// Сервис сетевых запросов
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Constants

    private enum Constants {
        static let baseURL = "https://api.edamam.com/api/recipes/v2"
        static let type = "public"
        static let appID = "eb15e1ec"
        static let appKey = "41b2ee9152e7908a48d4dffdd80361ea"
        static let dishTypeKey = "dishType"
                static let queryKey = "q"
                static let healthKey = "health"
                static let uriKey = "uri"
    }

    private let baseUrlComponents = {
            var component = URLComponents()
            component.scheme = "https"
            component.host = "api.edamam.com"
            component.path = "/api/recipes/v2"
            component.queryItems = [
                .init(name: "app_id", value: Constants.appID),
                .init(name: "app_key", value: Constants.appKey),
                .init(name: "type", value: Constants.type)
            ]
            return component
        }()

    /// Функция загрузки отдельного рецепта
    func getRecipeDetail(uri: String, completion: @escaping (Result<Recipe, Error>) -> Void) {
        var components = URLComponents(string: Constants.baseURL + "/by-uri")
        components?.queryItems = [
            URLQueryItem(name: "type", value: Constants.type),
            URLQueryItem(name: "app_id", value: Constants.appID),
            URLQueryItem(name: "app_key", value: Constants.appKey),
            URLQueryItem(name: "uri", value: uri)
        ]

        if let url = components?.url {
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                        return
                    }
                }
                guard let data = data else { return }
                do {
                    let object = try JSONDecoder().decode(ResponseDTO.self, from: data)
                    if let recipe = object.hits.first?.recipe {

                        DispatchQueue.main.async {
                            completion(.success(Recipe(dto: recipe)))
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }

    /// Функция загрузки массива рецептов определенной категории
    
    func getRecipes(
        dishType: RecipeType,
        health: String?,
        query: String?,
        completion: @escaping (Result<[Recipe], Error>) -> Void
    ) {
        var baseUrlComponents = baseUrlComponents
        baseUrlComponents.queryItems?.append(.init(name: Constants.dishTypeKey, value: dishType.dishCategory))
        if let query = query {
            baseUrlComponents.queryItems?.append(.init(name: Constants.queryKey, value: query))
        }
        if let health = health {
            baseUrlComponents.queryItems?.append(.init(name: Constants.healthKey, value: health))
        }

        guard let url = baseUrlComponents.url else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }

            do {
                let result = try JSONDecoder().decode(ResponseDTO.self, from: data)
                let recipes = result.hits.map { Recipe(dto: $0.recipe) }
                completion(.success(recipes))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    /// Функция загрузки изображений
    static func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = URL(string: urlString) else {
            print("Invalid image URL")
            
            completion(nil)
            return
        }
        print("image URL:", imageUrl)
        let session = URLSession.shared
        let task = session.dataTask(with: imageUrl) { data, response, error in
            guard error == nil, let data = data else {
                print("Failed to load image:", error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                print("Failed to create image from data")
                completion(nil)
            }
        }
        task.resume()
    }
}
