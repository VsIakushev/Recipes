// BottomSheetPresentor.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Протокол экрана нижней шторки
protocol BottomSheetViewControllerProtocol: AnyObject {}

// Протокол Презентора нижней шторки
protocol BottomSheetPresentorProtocol {
    func closeButtonPressed()
}

// Презентор нижней шторки
class BottomSheetPresentor: BottomSheetPresentorProtocol {
    weak var view: BottomSheetViewControllerProtocol?
    weak var coordinator: ProfileCoordinator?

    init(view: BottomSheetViewController, coordinator: ProfileCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }

    func closeButtonPressed() {
        coordinator?.closeBottomSheet()
    }
}
