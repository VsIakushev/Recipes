// CaloriesTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

class CaloriesTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .red
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
