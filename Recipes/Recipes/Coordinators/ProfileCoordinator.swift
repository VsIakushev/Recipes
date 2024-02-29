// ProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор профиля
final class ProfileCoordinator: BaseCoodinator {
    var rootController: UINavigationController
    var onFinishFlow: (() -> Void)?

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }

    func logOut() {
        onFinishFlow?()
    }

    func pushRecipe() {
        let recipeViewController = RecipeViewController()
        rootController.pushViewController(recipeViewController, animated: true)
    }

    func closeBottomSheet() {
        rootController.dismiss(animated: true)
    }

    func showBonusBottomSheet(bonuses: Int) {
        let bottomSheet = BottomSheetViewController()
        let presenter = BottomSheetPresentor(view: bottomSheet, coordinator: self)
        bottomSheet.setBonuses(bonuses: bonuses)
        bottomSheet.presenter = presenter as? any BottomSheetPresentorProtocol
        if let sheet = bottomSheet.sheetPresentationController {
            sheet.detents = [.custom(resolver: { context in
                355
            })]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
        }
        rootController.present(bottomSheet, animated: true)
    }
}
