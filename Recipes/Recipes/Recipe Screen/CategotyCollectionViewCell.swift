// CategotyCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка Категории рецепта для главного экрана рецептов
final class CategoryCollectionViewCell: UICollectionViewCell {
    // MARK: - Public Properties

    var cornerRadius: CGFloat = 0

    // MARK: - Visual Components

    private let imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true

        return imageView
    }()

    private let overlayView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        return view
    }()

    private let label = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.verdana20()
        return label
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Public Methods

    func setCellData(title: String, image: String) {
        label.text = title
        imageView.image = UIImage(named: image)
    }

    // MARK: - Public Methods

    func updateCornerRaduis(with radius: CGFloat) {
        imageView.layer.cornerRadius = radius
        overlayView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        overlayView.layer.cornerRadius = radius
    }

    // MARK: - Private Methods

    private func setupView() {
        contentView.addSubview(imageView)
        contentView.addSubview(overlayView)
        overlayView.addSubview(label)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            overlayView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            overlayView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.2),

            label.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            label.widthAnchor.constraint(equalTo: overlayView.widthAnchor),
            label.heightAnchor.constraint(equalTo: overlayView.heightAnchor)
        ])
    }
}
