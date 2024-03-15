// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол NetworkServiceProtocol
protocol NetworkServiceProtocol: AnyObject {
    /// Получение детального рецепта
    func getRecipeDetail(uri: String, completion: @escaping (Result<RecipeNetwork, Error>) -> Void)
    /// Получение рецептов
    func getRecipes(dishType: String, completion: @escaping (Result<[RecipeNetwork], Error>) -> Void)
}

/// Сервис сетевых запросов
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Constants

    private enum Constants {
        static let baseURL = "https://api.edamam.com/api/recipes/v2"
        static let type = "public"
        static let appID = "eb15e1ec"
        static let appKey = "41b2ee9152e7908a48d4dffdd80361ea"
    }

    /// Функция загрузки отдельного рецепта
    func getRecipeDetail(uri: String, completion: @escaping (Result<RecipeNetwork, Error>) -> Void) {
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
                            completion(.success(RecipeNetwork(dto: recipe)))
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
    func getRecipes(dishType: String, completion: @escaping (Result<[RecipeNetwork], Error>) -> Void) {
        var components = URLComponents(string: Constants.baseURL)
        components?.queryItems = [
            URLQueryItem(name: "type", value: Constants.type),
            URLQueryItem(name: "app_id", value: Constants.appID),
            URLQueryItem(name: "app_key", value: Constants.appKey),
            URLQueryItem(name: "dishType", value: dishType)
        ]

        if let url = components?.url {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("error in request")
                } else {
                    if let resp = response as? HTTPURLResponse,
                       resp.statusCode == 200,
                       let responseData = data
                    {
                        do {
                            let data = try
                                JSONDecoder().decode(ResponseDTO.self, from: responseData)
                            let recipes = data.hits.map { RecipeNetwork(dto: $0.recipe) }
                            completion(.success(recipes))

                        } catch {
                            print(error)
                        }
                    }
                }
            }.resume()
        }
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
