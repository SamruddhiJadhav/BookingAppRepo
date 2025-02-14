//
//  TripCardView.swift
//  Trips
//
//  Created by Samruddhi Jadhav on 3/2/25.
//

import UIKit
import BookingUI

final class TripCardViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: TripCardViewCell.self)

    private let cardContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = BUI.spacing2x
        view.backgroundColor = BUI.Color.backgroundElevationTwo.uiColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = Float(BUI.Shadow.shadow100.opacity)
        view.layer.shadowOffset = BUI.Shadow.shadow100.offset
        return view
    }()

    private let cardImage: DownloadableImageView = {
        let image = DownloadableImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = BUI.spacing2x
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        image.clipsToBounds = true
        image.sizeToFit()
        return image
    }()
    
    private let cardTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BUI.Font.headline3.uiFont
        label.textColor = BUI.Color.foreground.uiColor
        label.numberOfLines = 0
        return label
    }()
    
    private let tripDurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BUI.Font.emphasized2.uiFont
        label.textColor = BUI.Color.foreground.uiColor
        return label
    }()
    
    private let numberOfBookingsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = BUI.Font.emphasized2.uiFont
        label.textColor = BUI.Color.foreground.uiColor
        return label
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .vertical
        return stack
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        cardContainerView.layer.shadowPath = UIBezierPath(
            roundedRect: cardContainerView.bounds,
            cornerRadius: cardContainerView.layer.cornerRadius
        ).cgPath
    }

    func configure(_ viewModel: TripCardViewModel) {
        cardTitle.text = viewModel.tripLabel
        tripDurationLabel.text = viewModel.tripDuration
        numberOfBookingsLabel.text = viewModel.numberOfBookingLabel
    }
    
    func fetchImage(_ viewModel: TripCardViewModel) {
        guard let url = viewModel.imageUrl else {
            return
        }
        cardImage.image(for: url, size: cardImage.frame.size)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cardImage.cancelDownload()
        cardImage.image = nil
    }
}

private extension TripCardViewCell {
    func setupHierarchy() {
        addSubview(cardContainerView)
        cardContainerView.addSubview(cardImage)
        cardContainerView.addSubview(cardTitle)
        cardContainerView.addSubview(stack)
        stack.addArrangedSubview(tripDurationLabel)
        stack.addArrangedSubview(numberOfBookingsLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cardContainerView.topAnchor.constraint(equalTo: topAnchor, constant: BUI.spacing4x),
            cardContainerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -BUI.spacing4x),
            cardContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: BUI.spacing4x),
            cardContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -BUI.spacing4x),
            
            cardImage.widthAnchor.constraint(equalTo: cardContainerView.widthAnchor),
            cardImage.heightAnchor.constraint(equalTo: cardImage.widthAnchor, multiplier: 9/16),
            
            cardImage.topAnchor.constraint(equalTo: cardContainerView.topAnchor),
            cardImage.leadingAnchor.constraint(equalTo: cardContainerView.leadingAnchor),
            cardImage.trailingAnchor.constraint(equalTo: cardContainerView.trailingAnchor),
            cardImage.bottomAnchor.constraint(equalTo: cardTitle.topAnchor, constant: -BUI.spacing4x),
            cardTitle.leadingAnchor.constraint(equalTo: cardContainerView.leadingAnchor, constant: BUI.spacing4x),
            cardTitle.trailingAnchor.constraint(equalTo: cardContainerView.trailingAnchor, constant: -BUI.spacing4x),
            cardTitle.bottomAnchor.constraint(equalTo: stack.topAnchor, constant: -BUI.spacing2x),
            stack.leadingAnchor.constraint(equalTo: cardContainerView.leadingAnchor, constant: BUI.spacing4x),
            stack.trailingAnchor.constraint(equalTo: cardContainerView.trailingAnchor, constant: -BUI.spacing4x),
            stack.bottomAnchor.constraint(equalTo: cardContainerView.bottomAnchor, constant: -BUI.spacing4x)
        ])
    }
}
