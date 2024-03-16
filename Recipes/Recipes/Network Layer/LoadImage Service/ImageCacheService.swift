//
//  ImageCacheService.swift
//  Recipes
//
//  Created by Vitaliy Iakushev on 15.03.2024.
//

import UIKit

/// Сервис кэширования изображений
final class ImageCacheService: ImageCacheServiceProtocol {
    
    private let fileManager = FileManager.default
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        // Генерируем путь к файлу для кэширования изображения
        let imagePath = self.imagePath(for: url)
        
        // Проверяем, существует ли изображение в кэше
        if self.fileManager.fileExists(atPath: imagePath.path),
           let imageData = self.fileManager.contents(atPath: imagePath.path),
           let image = UIImage(data: imageData) {
            // Если изображение найдено в кэше, возвращаем его
            completion(image)
        } else {
            // Если изображение отсутствует в кэше, загружаем его из интернета
            self.downloadImage(from: url) { downloadedImage in
                // Сохраняем загруженное изображение в кэше перед возвратом
                if let downloadedImage = downloadedImage {
                    self.saveImage(downloadedImage, to: url)
                }
                completion(downloadedImage)
            }
        }
    }
    
    // Загружаем изображение из интернета
    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
    // Сохраняем изображение в файловой системе
    private func saveImage(_ image: UIImage, to url: URL) {
        let imageData = image.pngData()
        if let imageData = imageData {
            let imagePath = self.imagePath(for: url)
            do {
                try imageData.write(to: imagePath)
            } catch {
                print("Error saving image: \(error)")
            }
        }
    }
    
    // Генерируем путь к файлу для кэширования изображения
    private func imagePath(for url: URL) -> URL {
        let documentsDirectory = self.fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = url.lastPathComponent
        let imagePath = documentsDirectory.appendingPathComponent(fileName)
        return imagePath
    }
}
