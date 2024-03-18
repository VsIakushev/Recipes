// Fonts.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для быстрого доступа к необходимым Шрифтам
extension UIFont {
    /// Устанавливает шрифт Verdana-Bold размера 28
    static func verdanaBold28() -> UIFont {
        UIFont(name: "Verdana-Bold", size: 28) ?? UIFont.systemFont(ofSize: 28, weight: .bold)
    }

    /// Устанавливает шрифт Verdana-Bold размера 25
    static func verdanaBold25() -> UIFont {
        UIFont(name: "Verdana-Bold", size: 25) ?? UIFont.systemFont(ofSize: 25, weight: .bold)
    }

    /// Устанавливает шрифт Verdana-Bold размера 20
    static func verdanaBold20() -> UIFont {
        UIFont(name: "Verdana-Bold", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    /// Устанавливает шрифт Verdana-Bold размера 18
    static func verdanaBold18() -> UIFont {
        UIFont(name: "Verdana-Bold", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .bold)
    }

    /// Устанавливает шрифт Verdana-Bold размера 12
    static func verdanaBold12() -> UIFont {
        UIFont(name: "Verdana-Bold", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .bold)
    }

    /// Устанавливает шрифт Verdana размера 20
    static func verdana20() -> UIFont {
        UIFont(name: "Verdana", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)
    }

    /// Устанавливает шрифт Verdana размера 14
    static func verdana14() -> UIFont {
        UIFont(name: "Verdana", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold)
    }

    /// Устанавливает шрифт Verdana размера 12
    static func verdana12() -> UIFont {
        UIFont(name: "Verdana", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .bold)
    }

    /// Устанавливает шрифт Verdana размера 10
    static func verdana10() -> UIFont {
        UIFont(name: "Verdana", size: 10) ?? UIFont.systemFont(ofSize: 10, weight: .bold)
    }
}
