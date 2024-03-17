//
//  ImageCacheServiceProtocol.swift
//  Recipes
//
//  Created by Vermut xxx on 18.03.2024.
//

import Foundation

import UIKit
/// Протокол сервиса кэширования загрузки изображений
protocol ImageCacheServiceProtocol {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}
