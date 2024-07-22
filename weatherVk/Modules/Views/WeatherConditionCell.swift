//
//  WeatherConditionCell.swift
//  weatherVk
//
//  Created by test on 22.07.2024.
//

import UIKit

final class WeatherConditionCell: UICollectionViewCell {
    static let reuseID = Constants.reuceId
    
    private let iconImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.tintColor = UIColor(named: Constants.mainColor)
        return imgView
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .preferredFont(forTextStyle: .headline)
        lbl.textAlignment = .center
        lbl.textColor = UIColor(named: Constants.mainColor)
        return lbl
    }()
    
    private let verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: Constants.animationDuration) {
                self.backgroundColor = self.isSelected ? Constants.selectedBackgroundColor : Constants.deselectedBackgroundColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = Constants.cornerRadius
        self.clipsToBounds = true
        self.backgroundColor = Constants.deselectedBackgroundColor
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    private func setupUI() {
        verticalStack.addArrangedSubview(iconImageView)
        verticalStack.addArrangedSubview(titleLabel)
        
        addSubview(verticalStack)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: topAnchor, constant: Constants.stackInsets),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.stackInsets),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.stackInsets),
            verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.stackInsets)
        ])
    }
    
    func configure(image: UIImage?, title: String) {
        let defaultImage = UIImage(systemName: Constants.defImage) ?? UIImage()
        let icon = image ?? defaultImage
        
        DispatchQueue.main.async {
            self.iconImageView.image = icon
            self.titleLabel.text = title
        }
    }
    
    func runAnimation() {
        UIView.animate(withDuration: Constants.animationShortDuration) {
            self.alpha = Constants.animationAlphaBefore
            self.transform = CGAffineTransform(scaleX: Constants.animationScaleFactor,
                                               y: Constants.animationScaleFactor)
        } completion: { _ in
            self.alpha = Constants.animationAlphaAfter
            self.transform = .identity
        }
    }
}

// MARK: - Constants

fileprivate extension WeatherConditionCell {
    enum Constants {
        static let stackSpacing: CGFloat = 10
        static let stackInsets: CGFloat = 8
        static let cornerRadius: CGFloat = 14
        static let animationDuration: TimeInterval = 1
        static let animationShortDuration: TimeInterval = 0.2
        static let animationScaleFactor: CGFloat = 0.9
        static let animationAlphaBefore = 0.7
        static let animationAlphaAfter = 1.0
        static let selectedBackgroundColor: UIColor = .black.withAlphaComponent(1)
        static let deselectedBackgroundColor: UIColor = .white.withAlphaComponent(0.5)
        static let fatalError = "init(coder:) has not been implemented"
        static let reuceId = "WeatherConditionCellID"
        static let mainColor = "mainColor"
        static let defImage = "world"
    }
}
