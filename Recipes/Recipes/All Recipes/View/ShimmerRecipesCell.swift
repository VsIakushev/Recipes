// ShimmerRecipesCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка Шиммера, для отображения в момент загрузки данных
final class ShimmerRecipesCell: UITableViewCell {
    // MARK: - Visual Components

    private let shimmerView = UIView()
    private let shimmerLayer = CAGradientLayer()

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
        shimmerLayer.frame = shimmerView.bounds
        shimmerLayer.cornerRadius = 12
    }

    // MARK: - Private Methods

    private func setup() {
        shimmerLayer.startPoint = CGPoint(x: 0, y: 0.5)
        shimmerLayer.endPoint = CGPoint(x: 1, y: 0.5)
        shimmerView.layer.addSublayer(shimmerLayer)

        let animationGroup = makeAnimationGroup()

        animationGroup.beginTime = 0
        shimmerLayer.add(animationGroup, forKey: "backgroundColor")
    }

    private func layout() {
        addSubview(shimmerView)

        shimmerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            shimmerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            shimmerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            shimmerView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            shimmerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            shimmerView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

// MARK: - ShimmerRecipesCell  + ShimmerLoadable

extension ShimmerRecipesCell: ShimmerLoadable {}
