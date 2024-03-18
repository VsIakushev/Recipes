//
//  ImageCacheProxy.swift
//  Recipes
//
//  Created by Vitaliy Iakushev on 15.03.2024.
//

import Foundation

import UIKit

/// Прокси для загрузки и кэширования изображений
final class ImageCacheProxy: ImageCacheServiceProtocol {
    
    private let imageCacheService = ImageCacheService()
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        imageCacheService.loadImage(from: url, completion: completion)
    }
}
