// ProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор профиля
final class ProfileCoordinator: BaseCoodinator {
    var rootController: UINavigationController!
    var onFinishFlow: (() -> Void)?

//    init(rootController: UIViewController) {
//
//    }

    func setRootViewController(view: UIViewController) {
        rootController = UINavigationController(rootViewController: view)
    }

    func logOut() {
        onFinishFlow?()
    }

    func pushRecipe() {
        let recipeViewController = RecipeViewController()
        rootController?.pushViewController(recipeViewController, animated: true)
    }

    func closeBottomSheet() {
        rootController?.dismiss(animated: true)
    }

    func showBonusBottomSheet(bonuses: Int) {
        let bottomSheet = BottomSheetViewController()
        let presenter = BottomSheetPresenter(view: bottomSheet, coordinator: self)
        bottomSheet.setBonuses(bonuses: bonuses)
        bottomSheet.presenter = presenter
        if let sheet = bottomSheet.sheetPresentationController {
            sheet.detents = [.custom(resolver: { context in
                355
            })]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
        }
        rootController.present(bottomSheet, animated: true)
    }
    
    func showTermsAndPolicySheet() {
        
        let termsAndPrivacySheet = TermsAndPolicyViewController()
        let presenter = TermsAndPolicyPresenter(view: termsAndPrivacySheet, coordinator: self)
        termsAndPrivacySheet.presenter = presenter
        
        rootController.present(termsAndPrivacySheet, animated: true)
    }
}
