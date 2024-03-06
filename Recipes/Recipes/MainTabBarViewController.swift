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
//
//        let navigationBarAppearance = UINavigationBarAppearance()
//        navigationBarAppearance.configureWithOpaqueBackground()
//        navigationBarAppearance.titleTextAttributes = [
//            NSAttributedString.Key.foregroundColor: UIColor.white
//        ]
//        navigationBarAppearance.backgroundColor = UIColor.white
//        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
//        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
//
//        let tabBarAppearance = UITabBarAppearance()
//        tabBarAppearance.configureWithOpaqueBackground()
//        tabBarAppearance.backgroundColor = UIColor.white
//        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
//        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
}
