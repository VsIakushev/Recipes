// ImageCacheProxy.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

import UIKit

/// Прокси для загрузки и кэширования изображений
final class ImageCacheProxy: ImageCacheServiceProtocol {
    private let imageCacheService = ImageCacheService()

    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        imageCacheService.loadImage(from: url, completion: completion)
    }
}
