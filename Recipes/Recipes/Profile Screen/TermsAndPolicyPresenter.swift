// BottomSheetPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Протокол экрана Условий и Политики конфиденциальности
protocol TermsAndPolicyPresenterViewControllerProtocol: AnyObject {}

// Протокол Презентора экрана Условий и Политики конфиденциальности
protocol TermsAndPolicyPresenterProtocol {
    /// закрытие экрана Условий и Политики конфиденциальности
    func closeTermsSheet()
}

// Презентор нижней шторки
final class TermsAndPolicyPresenter: TermsAndPolicyPresenterProtocol {
    // MARK: - Public Properties

    weak var view: TermsAndPolicyPresenterViewControllerProtocol?

    private weak var coordinator: ProfileCoordinator?

    // MARK: - Initializers

    init(view: TermsAndPolicyPresenterViewControllerProtocol, coordinator: ProfileCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }

    // MARK: - Public Methods

    // TODO: Проверить. По идее эта же функция должна закрывать и этот экран
    func closeTermsSheet() {
        coordinator?.closeBottomSheet()
    }
}
