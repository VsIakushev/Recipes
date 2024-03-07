// Colors.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для быстрого доступа к необходимым Шрифтам
extension UIColor {
    /// Устанавливает цвет background01 из Assets
    static func background01() -> UIColor {
        UIColor(named: "background01") ?? UIColor.gray
    }

    /// Устанавливает цвет background02 из Assets
    static func background02() -> UIColor {
        UIColor(named: "background02") ?? UIColor.gray
    }

    /// Устанавливает цвет background03 из Assets
    static func background03() -> UIColor {
        UIColor(named: "background03") ?? UIColor.gray
    }

    /// Устанавливает цвет background04 из Assets
    static func background04() -> UIColor {
        UIColor(named: "background04") ?? UIColor.gray
    }

    /// Устанавливает цвет background05 из Assets
    static func background05() -> UIColor {
        UIColor(named: "background05") ?? UIColor.gray
    }

    /// Устанавливает цвет background06 из Assets
    static func background06() -> UIColor {
        UIColor(named: "background06") ?? UIColor.gray
    }

    /// Устанавливает цвет background07 из Assets
    static func background07() -> UIColor {
        UIColor(named: "background07") ?? UIColor.gray
    }

    /// Устанавливает цвет background08 из Assets
    static func background08() -> UIColor {
        UIColor(named: "background08") ?? UIColor.gray
    }

    /// Устанавливает цвет text01 из Assets
    static func text01() -> UIColor {
        UIColor(named: "text01") ?? UIColor.gray
    }

    /// Устанавливает цвет text02 из Assets
    static func text02() -> UIColor {
        UIColor(named: "text02") ?? UIColor.gray
    }

    /// Устанавливает цвет text03 из Assets
    static func text03() -> UIColor {
        UIColor(named: "text03") ?? UIColor.gray
    }

    /// Устанавливает цвет text04 из Assets
    static func text04() -> UIColor {
        UIColor(named: "text04") ?? UIColor.gray
    }

    /// Устанавливает цвет divider02 из Assets
    static func divider02() -> UIColor {
        UIColor(named: "divider02") ?? UIColor.gray
    }

    /// Устанавливает светло-серый цвет
    static var gradientLightGrey: UIColor {
        UIColor(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 1)
    }

    /// Устанавливает серый цвет
    static var gradientDarkGrey: UIColor {
        UIColor(red: 239 / 255, green: 241 / 255, blue: 241 / 255, alpha: 1)
    }
}
