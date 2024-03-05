// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран профиля
final class ProfileViewController: UIViewController {
    
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

    private let tableView = UITableView()

    // MARK: - Public Properties

    var presenter: ProfilePresenterProtocol?

    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupNavigation()
        setupTableView()
        
        // TODO: Temporary
        setupTermsScreen()
        
        
    }

    // MARK: - Public Methods

    func setupUI() {
        tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "smile"),
            selectedImage: UIImage(named: "smile.fill")
        )
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
//            self?.presenter?.termsAndPolictPressed()
            self?.toggleTermsScreenVisibility()
            
        }
    }

    @objc private func onTapLogOutAction() {
        presenter?.onLogOut()
    }
    
    
    // MARK: - Temporary Animation code below
    
    
    // Additional functions
    
    private func hideTermScreen() {
        termsViewController.view.isHidden = true
        visualEffectView.isHidden = true
    }
    
    private func toggleTermsScreenVisibility() {
//        termsViewController.view.isHidden = !termsViewController.view.isHidden
//        visualEffectView.isHidden = !visualEffectView.isHidden
        
        // Это работает:
        if termsViewController.view.isHidden {
                // Show terms screen and visual effect view
                termsViewController.view.isHidden = false
                visualEffectView.isHidden = false
            self.tabBarController?.tabBar.isHidden = true
                
                // Position terms screen and visual effect view at the top
                termsViewController.view.frame.origin.y = view.frame.height
                visualEffectView.frame.origin.y = 0
                
                // Optionally, you can also start the animation here if needed
                animateTransitionIfNeeded(state: .expanded, duration: 0.9)
            } else {
                // Hide terms screen and visual effect view
                termsViewController.view.isHidden = true
                visualEffectView.isHidden = true
                self.tabBarController?.tabBar.isHidden = false
                // Optionally, you can also start the animation here if needed
                animateTransitionIfNeeded(state: .collapsed, duration: 0.9)
            }
        
        
    }
    
    // _____________
    
    enum TermsScreenState {
        case expanded
        case collapsed
    }
    
    var termsViewController : TermsAndPolicyViewController!
    var visualEffectView: UIVisualEffectView!
    
    let termsScreenHeight: CGFloat = 700
    let termsScreenHandleAreaHight: CGFloat = 125
    
    var cardVisible = false
    
    var nextState: TermsScreenState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    
    var animationProgressWhenInterrupted: CGFloat = 0

    
    func setupTermsScreen() {
        
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        termsViewController = TermsAndPolicyViewController()
        
        self.addChild(termsViewController)
        view.addSubview(termsViewController.view)
        
        termsViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - termsScreenHandleAreaHight - 150, width: self.view.bounds.width, height: termsScreenHeight)
        
        termsViewController.view.clipsToBounds = true
//        termsViewController.view.translatesAutoresizingMaskIntoConstraints = true
//        
//        NSLayoutConstraint.activate([
//            termsViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
//            termsViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            termsViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            termsViewController.view.heightAnchor.constraint(equalToConstant: 600),
//        ])
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(recognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer: )))
        
        termsViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        termsViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
        hideTermScreen()
    }
    
    @objc func handleCardTap(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc func handleCardPan(recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
        case .began :
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let trastlation = recognizer.translation(in: self.termsViewController.handleArea)
            var fractionComplete = trastlation.y / termsScreenHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended :
            continueInteractiveTransition()
        default : break
        }
    }
    
    func animateTransitionIfNeeded(state: TermsScreenState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.termsViewController.view.frame.origin.y = self.view.frame.height - self.termsScreenHeight
                case .collapsed: self.termsViewController.view.frame.origin.y = self.view.frame.height - self.termsScreenHandleAreaHight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.termsViewController.dismiss(animated: true)
//                self.visualEffectView.isHidden = true
//                self.termsViewController.view.isHidden = true
//                self.tabBarController?.tabBar.isHidden = false
                self.runningAnimations.removeAll()
                
                if !self.cardVisible {
                    self.tabBarController?.tabBar.isHidden = false
                    self.visualEffectView.isHidden = true
                    self.termsViewController.view.isHidden = true
                }
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded :
                    self.termsViewController.view.layer.cornerRadius = 25
                case .collapsed:
                    self.termsViewController.view.layer.cornerRadius = 0
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
    
    func startInteractiveTransition(state: TermsScreenState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
                animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
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
