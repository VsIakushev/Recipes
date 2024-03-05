// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран профиля
final class ProfileViewController: UIViewController {
    
    /// Состояние всплывающего окна с Условиями и Политикой Конфиденциальности
    private enum TermsScreenState {
        /// Окно развернуто
        case expanded
        /// Окно закрыто
        case collapsed
    }
    
    // MARK: - Constants
    private enum Constants {
        static let titleText = "Profile"
        static let titleFont = UIFont(name: "Verdana-Bold", size: 28)
        static let alertTitle = "Change your name and surname"
        static let alertTextFieldPlaceholder = "Name Surname"
        static let alertOkText = "Ok"
        static let alertCancelText = "Cancel"
    }

    // MARK: - Visual Components

    var termsView = TermsAndPolicyView()
    private let tableView = UITableView()
    
    // MARK: - Public Properties

    var presenter: ProfilePresenterProtocol?
    
    // MARK: - Private Properties
    private var visualEffectView: UIVisualEffectView!
    private let termsScreenHeight: CGFloat = 700
    private let termsScreenHandleAreaHight: CGFloat = 0
    private var cardVisible = false
    
    private var nextState: TermsScreenState {
        return cardVisible ? .collapsed : .expanded
    }
    
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterrupted: CGFloat = 0
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupNavigation()
        setupTableView()
    }

    // MARK: - Public Methods

    func setupUI() {
        tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "smile"),
            selectedImage: UIImage(named: "smile.fill")
        )
    }
    
    func showTermsAndPolicy() {
        termsView = TermsAndPolicyView()
        setupTermsScreen()
        
        termsView.frame.origin.y = view.frame.height
        visualEffectView.frame.origin.y = 0
        animateTransitionIfNeeded(state: .expanded, duration: 0.9)
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        windowScene?.windows.last?.addSubview(termsView)
    }

    // MARK: - Private Methods

    private func setupNavigation() {
        let titleLabel = UILabel()
        titleLabel.font = Constants.titleFont
        titleLabel.text = Constants.titleText
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileCell")
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: "ButtonCell")
    }

    private func showAlert(completion: @escaping StringHandler) {
        let alert = UIAlertController(title: Constants.alertTitle, message: nil, preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = Constants.alertTextFieldPlaceholder
        }

        let okAction = UIAlertAction(title: Constants.alertOkText, style: .default) { _ in
            if let textField = alert.textFields?.first, let text = textField.text {
                completion(text)
            }
        }

        let cancelAction = UIAlertAction(title: Constants.alertCancelText, style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        alert.preferredAction = okAction

        present(alert, animated: true)
    }

    private func configureButtonCell(for cell: ButtonTableViewCell) {
        cell.configureCell(bonuses: presenter?.profileInfo.bonuses ?? 0)

        cell.bonusButtonAction = { [weak self] in
            self?.presenter?.bonusButtonPressed()
        }
        cell.logoutButtonAction = { [weak self] in
            self?.presenter?.onLogOut()
        }
        cell.termsAndPolicyButtonAction = { [weak self] in
            self?.presenter?.termsAndPolictPressed(profileViewController: self!)
        }
    }

   
    
    private func setupTermsScreen() {
        
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        termsView.frame = CGRect(x: 0, y: self.view.frame.height - termsScreenHandleAreaHight, width: self.view.bounds.width, height: termsScreenHeight)
  
        termsView.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(recognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer: )))
        
        termsView.handleArea.addGestureRecognizer(tapGestureRecognizer)
        termsView.handleArea.addGestureRecognizer(panGestureRecognizer)
    }
    
    
    
    private func animateTransitionIfNeeded(state: TermsScreenState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.termsView.frame.origin.y = self.view.frame.height - self.termsScreenHeight
                case .collapsed: self.termsView.frame.origin.y = self.view.frame.height - self.termsScreenHandleAreaHight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
                
                if !self.cardVisible {
                    self.termsView.isHidden = true
                    self.visualEffectView.isHidden = true
                }
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded :
                    self.termsView.layer.cornerRadius = 25
                case .collapsed:
                    self.termsView.layer.cornerRadius = 0
                }
            }
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
        }
        
    }
    
    private func startInteractiveTransition(state: TermsScreenState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
                animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    private func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
    @objc private func onTapLogOutAction() {
        presenter?.onLogOut()
    }
    
    @objc private func handleCardTap(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc private func handleCardPan(recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
        case .began :
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let trastlation = recognizer.translation(in: self.termsView.handleArea)
            var fractionComplete = trastlation.y / termsScreenHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended :
            continueInteractiveTransition()
        default : break
        }
    }
}

// MARK: - ProfileViewController+ProfileViewProtocol

extension ProfileViewController: ProfileViewProtocol {
    func showEditAlert() {
        showAlert { [weak self] editedName in
            self?.presenter?.setName(newName: editedName)
        }
    }

    func updateView() {
        tableView.reloadData()
    }
}

/// MARK: - ProfileViewController+UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileTableViewCell,
                let presenter = presenter
            else { return UITableViewCell() }

            cell.configureCell(info: presenter.profileInfo)
            cell.editButtonAction = { [weak self] in
                self?.presenter?.editTapped()
            }
            return cell

        } else {
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as? ButtonTableViewCell
            else { return UITableViewCell() }
            configureButtonCell(for: cell)
            return cell
        }
    }
    
    
    
}

// MARK: ProfileViewController + функционал Property Animator
extension ProfileViewController {
    
    
}
