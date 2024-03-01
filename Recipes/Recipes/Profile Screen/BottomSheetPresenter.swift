// BottomSheetPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Протокол экрана нижней шторки
protocol BottomSheetViewControllerProtocol: AnyObject {}

// Протокол Презентора нижней шторки
protocol BottomSheetPresentorProtocol {
    /// закрытие шторки кнопкой
    func closeBottomSheet()
}

// Презентор нижней шторки
final class BottomSheetPresenter: BottomSheetPresentorProtocol {
    // MARK: - Public Properties

    weak var view: BottomSheetViewControllerProtocol?

    private weak var coordinator: ProfileCoordinator?

    // MARK: - Initializers

    init(view: BottomSheetViewController, coordinator: ProfileCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }

    // MARK: - Public Methods

    func closeBottomSheet() {
        coordinator?.closeBottomSheet()
    }
}
