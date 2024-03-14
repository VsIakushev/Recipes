// UserDefaultsWrapper.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол PropertyWrapper'а для UserDefaults
protocol UserDefaultsWrapperProtocol {
    associatedtype Value
    /// Загружаемое/Сохраняемое в userDefaults значение
    var wrappedValue: Value { get set }
    /// Ключ для значения
    var key: String { get }
}

/// PropertyWrapper для UserDefaults
@propertyWrapper
struct UserDefaultsWrapper<T>: UserDefaultsWrapperProtocol {
    typealias Value = T

    let key: String

    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }

    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
