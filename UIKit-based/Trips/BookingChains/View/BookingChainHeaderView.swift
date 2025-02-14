//
//  BookingChainHeaderView.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 4/2/25.
//

import BookingUI
import UIKit

class BookingChainHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier = String(describing: BookingChainHeaderView.self)

    private let sectionTitle: UILabel = {
        let label = UILabel()
        label.font = BUI.Font.headline2.uiFont
        label.textColor = BUI.Color.foreground.uiColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = BUI.Color.backgroundBase.uiColor
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with title: String) {
        sectionTitle.text = title
    }
}

private extension BookingChainHeaderView {
    func setupHierarchy() {
        contentView.addSubview(sectionTitle)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            sectionTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: BUI.spacing4x),
            sectionTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -BUI.spacing4x),
            sectionTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: BUI.spacing4x),
            sectionTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
