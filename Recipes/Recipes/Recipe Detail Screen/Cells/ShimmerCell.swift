//
//  ShimmerDetailsCell.swift
//  Recipes
//
//  Created by Vitaliy Iakushev on 14.03.2024.
//

import UIKit

/// Ячейка Шиммера, для отображения в момент загрузки данных
class ShimmerCell: UITableViewCell {

    // MARK: - Visual Components

    private let shimmerLabelView = UIView()
    private let shimmerImageView = UIView()
    private let shimmerCaloriesView = UIView()
    private let shimmerRecipeView = UIView()
    
    
    private let shimmerImageLayer = CAGradientLayer()
    private let shimmerLabelLayer = CAGradientLayer()
    private let shimmerCaloriesLayer = CAGradientLayer()
    private let shimmerRecipeLayer = CAGradientLayer()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        layout()
    }

    // MARK: - Life Cycles

    override func layoutSubviews() {
        super.layoutSubviews()
        shimmerLabelLayer.frame = shimmerLabelView.bounds
        
        shimmerImageLayer.frame = shimmerImageView.bounds
        shimmerImageLayer.cornerRadius = 24
        
        shimmerCaloriesLayer.frame = shimmerCaloriesView.bounds
        shimmerCaloriesLayer.cornerRadius = 16
        
        shimmerRecipeLayer.frame = shimmerRecipeView.bounds
        shimmerRecipeLayer.cornerRadius = 24
        
    }

    // MARK: - Private Methods

    private func setup() {
        shimmerLabelLayer.startPoint = CGPoint(x: 0, y: 0.5)
        shimmerLabelLayer.endPoint = CGPoint(x: 1, y: 0.5)
        shimmerLabelView.layer.addSublayer(shimmerLabelLayer)
        
        shimmerCaloriesLayer.startPoint = CGPoint(x: 0, y: 0.5)
        shimmerCaloriesLayer.endPoint = CGPoint(x: 1, y: 0.5)
        shimmerCaloriesView.layer.addSublayer(shimmerCaloriesLayer)
        
        shimmerImageLayer.startPoint = CGPoint(x: 0, y: 0.5)
        shimmerImageLayer.endPoint = CGPoint(x: 1, y: 0.5)
        shimmerImageView.layer.addSublayer(shimmerImageLayer)
        
        shimmerRecipeLayer.startPoint = CGPoint(x: 0, y: 0.5)
        shimmerRecipeLayer.endPoint = CGPoint(x: 1, y: 0.5)
        shimmerRecipeView.layer.addSublayer(shimmerRecipeLayer)

        let animationGroup = makeAnimationGroup()

        animationGroup.beginTime = 0
        shimmerImageLayer.add(animationGroup, forKey: "backgroundColor")
        shimmerLabelLayer.add(animationGroup, forKey: "backgroundColor")
        shimmerCaloriesLayer.add(animationGroup, forKey: "backgroundColor")
        shimmerRecipeLayer.add(animationGroup, forKey: "backgroundColor")
    }

    private func layout() {
        addSubview(shimmerImageView)
        addSubview(shimmerLabelView)
        addSubview(shimmerCaloriesView)
        addSubview(shimmerRecipeView)

        shimmerImageView.translatesAutoresizingMaskIntoConstraints = false
        shimmerLabelView.translatesAutoresizingMaskIntoConstraints = false
        shimmerCaloriesView.translatesAutoresizingMaskIntoConstraints = false
        shimmerRecipeView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            shimmerLabelView.centerXAnchor.constraint(equalTo: centerXAnchor),
            shimmerLabelView.topAnchor.constraint(equalTo: topAnchor),
            shimmerLabelView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            shimmerLabelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            shimmerLabelView.widthAnchor.constraint(equalToConstant: 350),
            shimmerLabelView.heightAnchor.constraint(equalToConstant: 23),
        
            shimmerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45),
            shimmerImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -45),
            shimmerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 43),
            shimmerImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            shimmerImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            shimmerImageView.widthAnchor.constraint(equalToConstant: 300),
            shimmerImageView.heightAnchor.constraint(equalToConstant: 300),
            
            shimmerCaloriesView.centerXAnchor.constraint(equalTo: centerXAnchor),
            shimmerCaloriesView.topAnchor.constraint(equalTo: shimmerImageView.bottomAnchor, constant: 20),
            shimmerCaloriesView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            shimmerCaloriesView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            shimmerCaloriesView.widthAnchor.constraint(equalToConstant: 310),
            shimmerCaloriesView.heightAnchor.constraint(equalToConstant: 74),
            
            shimmerRecipeView.widthAnchor.constraint(equalTo: widthAnchor),
            shimmerRecipeView.heightAnchor.constraint(equalToConstant: 400),
            shimmerRecipeView.topAnchor.constraint(equalTo: shimmerCaloriesView.bottomAnchor, constant: 20),
            
        ])
    }
}

// MARK: - ShimmerDetailsCell  + ShimmerLoadable
extension ShimmerCell: ShimmerLoadable {}

