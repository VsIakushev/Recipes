// MainTabBarViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

class MainTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        tabBar.tintColor = UIColor(named: "background01")
        tabBar.unselectedItemTintColor = UIColor(named: "text02")
    }
}
