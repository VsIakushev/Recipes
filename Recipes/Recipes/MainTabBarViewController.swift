// MainTabBarViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// ТабБар навигации приложения
final class MainTabBarViewController: UITabBarController {
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        view.backgroundColor = .white
        tabBar.tintColor = UIColor.background01()
        tabBar.unselectedItemTintColor = UIColor.text02()
    }
}
