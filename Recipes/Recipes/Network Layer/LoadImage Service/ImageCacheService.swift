//
//  ImageCacheService.swift
//  Recipes
//
//  Created by Vermut xxx on 18.03.2024.
//

import UIKit

/// Сервис кэширования изображений
final class ImageCacheService: ImageCacheServiceProtocol {
    
    private let fileManager = FileManager.default
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let imagePath = self.imagePath(for: url)
        
        if self.fileManager.fileExists(atPath: imagePath.path),
           let imageData = self.fileManager.contents(atPath: imagePath.path),
           let image = UIImage(data: imageData) {
            completion(image)
        } else {
            self.downloadImage(from: url) { downloadedImage in
                if let downloadedImage = downloadedImage {
                    self.saveImage(downloadedImage, to: url)
                }
                completion(downloadedImage)
            }
        }
    }
    
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
    
    private func imagePath(for url: URL) -> URL {
        let documentsDirectory = self.fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = url.lastPathComponent
        let imagePath = documentsDirectory.appendingPathComponent(fileName)
        return imagePath
    }
}
