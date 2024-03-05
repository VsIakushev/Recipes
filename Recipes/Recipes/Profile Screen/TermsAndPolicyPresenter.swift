// BottomSheetPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Протокол экрана Условий и Политики конфиденциальности
protocol TermsAndPolicyPresenterViewProtocol: AnyObject { }

// Протокол Презентора экрана Условий и Политики конфиденциальности
protocol TermsAndPolicyPresenterProtocol {
    /// закрытие экрана Условий и Политики конфиденциальности
    func closeTermsSheet()
}

// Презентор нижней шторки
final class TermsAndPolicyPresenter: TermsAndPolicyPresenterProtocol {
    // MARK: - Public Properties

    weak var view: TermsAndPolicyPresenterViewProtocol?

    private weak var coordinator: ProfileCoordinator?

    // MARK: - Initializers

    init(view: TermsAndPolicyPresenterViewProtocol, coordinator: ProfileCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }

    // MARK: - Public Methods

    func closeTermsSheet() {
        coordinator?.closeTermsAndPolicyView()
    }
}
