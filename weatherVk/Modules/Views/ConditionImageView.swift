//
//  ConditionImageView.swift
//  weatherVk
//
//  Created by test on 22.07.2024.
//

import UIKit

final class ConditionImageView: UIView {
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Constants.backgroundColor
        
        createUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    private func createUI() {
        addSubview(imageView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setImage(with image: UIImage?) {
        guard let image else { return }
        
        UIView.animate(withDuration: Constants.fadeOutDuration) {
            self.imageView.alpha = Constants.fadeOutAlpha
        } completion: { _ in
            UIView.animate(withDuration: Constants.fadeInDuration) {
                self.imageView.alpha = Constants.fadeInAlpha
                self.imageView.image = image
            }
        }
    }
}

// MARK: - Constants

private extension ConditionImageView {
    enum Constants {
        static let backgroundColor: UIColor = .systemPurple
        static let fadeOutDuration: TimeInterval = 0.5
        static let fadeInDuration: TimeInterval = 1
        static let fadeOutAlpha: CGFloat = 0.1
        static let fadeInAlpha: CGFloat = 1
        static let fatalError = "init(coder:) has not been implemented"
    }
}
