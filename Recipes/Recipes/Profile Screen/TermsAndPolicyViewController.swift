//
//  TermsAndPolicyViewController.swift
//  Recipes
//
//  Created by Vitaliy Iakushev on 04.03.2024.
//

import UIKit

class TermsAndPolicyViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let titleText = "Terms of Use"
        static let titleFont = UIFont(name: "Verdana-Bold", size: 20)
        static let termsFont = UIFont(name: "Verdana", size: 14)
        static let termsText = """
        Welcome to our recipe app! We're thrilled to have you on board. To ensure a delightful experience for everyone, please take a moment to familiarize yourself with our rules:
        User Accounts:
        ﻿﻿• Maintain one account per user.
        ﻿﻿• Safeguard your login credentials; don't share them with others.
        Content Usage:
        ﻿﻿• Recipes and content are for personal use only.
        ﻿﻿• Do not redistribute or republish recipes without proper attribution.
        Respect Copyright:
        ﻿﻿• Honor the copyright of recipe authors and contributors.
        ﻿﻿• Credit the original source when adapting or modifying a recipe.
        Community Guidelines:
        ﻿﻿• Show respect in community features.
        ﻿﻿• Avoid offensive language or content that violates community standards.
        Feedback and Reviews:
        ﻿﻿• Share constructive feedback and reviews.
        ﻿﻿• Do not submit false or misleading information.
        Data Privacy:
        • Review and understand our privacy policy regarding data collection and usage.
        Compliance with Laws:
        • Use the app in compliance with all applicable laws and regulations.
        Updates to Terms:
        • Stay informed about updates; we'll notify you of any changes.
        By using our recipe app, you agree to adhere to these rules. Thank you for being a part of our culinary community! Enjoy exploring and cooking up a storm!
        """
    }

    // MARK: - Visual Components

    private let closeButton = UIButton()
    private let termsTitleLabel = UILabel()
    private let termsLabel = UILabel()
    private let scrollView = UIScrollView()
    
    // MARK: - Public Properties
    var presenter: TermsAndPolicyPresenterProtocol?
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupUI()
        setConstraints()
    }
    
    // MARK: - Private Methods

    private func addViews() {
        view.addSubview(closeButton)
        view.addSubview(termsTitleLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(termsLabel)
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isScrollEnabled = true

        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = UIColor(named: "text02")
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        termsTitleLabel.text = Constants.titleText
        termsTitleLabel.font = Constants.titleFont
        termsTitleLabel.textAlignment = .left
        termsTitleLabel.textColor = .black

        termsLabel.text = "\(Constants.termsText)"
        termsLabel.numberOfLines = 0
        termsLabel.textAlignment = .left
        termsLabel.font = Constants.termsFont
        termsLabel.textColor = .black
    }

    private func setConstraints() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        termsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        termsLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            closeButton.widthAnchor.constraint(equalToConstant: 13),
            closeButton.heightAnchor.constraint(equalToConstant: 13),

            termsTitleLabel.widthAnchor.constraint(equalToConstant: 170),
            termsTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            termsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            termsTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),

            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            scrollView.topAnchor.constraint(equalTo: termsTitleLabel.bottomAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            
            termsLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            termsLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            termsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            termsLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            termsLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            
        ])
    }
    
    @objc private func closeButtonTapped() {
        presenter?.closeTermsSheet()
    }

}

// MARK: - TermsAndPolicyViewController + TermsAndPolicyPresenterViewControllerProtocol
extension TermsAndPolicyViewController: TermsAndPolicyPresenterViewControllerProtocol {}
