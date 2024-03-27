// ImageCacheServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол сервиса кэширования загрузки изображений
protocol ImageCacheServiceProtocol {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}
