// Fonts.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// LightWeight для Шрифтов
extension UIFont {
    static func verdanaBold28() -> UIFont {
        UIFont(name: "Verdana-Bold", size: 28) ?? UIFont.systemFont(ofSize: 28, weight: .bold)
    }

    static func verdanaBold25() -> UIFont {
        UIFont(name: "Verdana-Bold", size: 25) ?? UIFont.systemFont(ofSize: 25, weight: .bold)
    }

    static func verdanaBold12() -> UIFont {
        UIFont(name: "Verdana-Bold", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .bold)
    }

    static func verdanaBold20() -> UIFont {
        UIFont(name: "Verdana-Bold", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)
    }

    static func verdana20() -> UIFont {
        UIFont(name: "Verdana", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)
    }

    static func verdana14() -> UIFont {
        UIFont(name: "Verdana", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold)
    }

    static func verdana12() -> UIFont {
        UIFont(name: "Verdana", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .bold)
    }

    static func verdana10() -> UIFont {
        UIFont(name: "Verdana", size: 10) ?? UIFont.systemFont(ofSize: 10, weight: .bold)
    }
}
