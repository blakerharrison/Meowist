//
//  LoginHeaderView.swift
//  
//
//  Created by bhrs on 9/13/20.
//

import UIKit

class LoginHeaderView: UIView {

    // MARK: - Dimensions
    private struct Dimensions {
        static let logoHeightAndWidth: CGFloat = 100
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    private lazy var logo: UIImageView =  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "meowistLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Setups
    private func addSubviews() {
        addSubview(logo)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // logo
            logo.leadingAnchor.constraint(equalTo: leadingAnchor),
            logo.trailingAnchor.constraint(equalTo: trailingAnchor),
            logo.topAnchor.constraint(equalTo: topAnchor),
            logo.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // view
            heightAnchor.constraint(equalToConstant: Dimensions.logoHeightAndWidth)
        ])
    }

}
