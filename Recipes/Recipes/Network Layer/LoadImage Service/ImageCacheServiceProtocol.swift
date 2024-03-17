//
//  ImageCacheServiceProtocol.swift
//  Recipes
//
//  Created by Vitaliy Iakushev on 17.03.2024.
//


import UIKit
/// Протокол сервиса кэширования загрузки изображений
protocol ImageCacheServiceProtocol {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}

