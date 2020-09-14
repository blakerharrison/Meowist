//
//  LoginCredentialsView.swift
//  Meowist
//
//  Created by bhrs on 9/13/20.
//  Copyright © 2020 Blake. All rights reserved.
//

import UIKit

class LoginCredentialsView: UIView {

    // MARK: - Dimensions
    private struct Dimensions {
        static let logoHeightAndWidth: CGFloat = 100
        static let margin: CGFloat = 16
        static let textFieldTopMargin: CGFloat = 30
        static let textFieldHeight: CGFloat = 60
        static let textFieldIconSizes: CGFloat = 25
        static let usernameAndPasswordMargin: CGFloat = 35
        static let viewHeight: CGFloat = 200
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
    lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = NSLocalizedString("email_placeholder_text", comment: "")
        textField.backgroundColor = .clear
        textField.returnKeyType = .next
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = NSLocalizedString("password_placeholder_text", comment: "")
        textField.backgroundColor = .clear
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var loginTextFieldBorder: UIView = {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = .white
        border.layer.cornerRadius = 5
        border.layer.borderWidth = 1
        border.layer.borderColor = UIColor.gray.cgColor
        return border
    }()
    
    lazy var passwordTextFieldBorder: UIView = {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = .white
        border.layer.cornerRadius = 5
        border.layer.borderWidth = 1
        border.layer.borderColor = UIColor.gray.cgColor
        return border
    }()
    
    lazy var emailIcon: UIImageView =  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "emailIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var passwordIcon: UIImageView =  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "passwordIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var forgotLogin: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("forgot_login_button_title", comment: ""), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = Theme.Fonts.hyperlink
        return button
    }()
    
    lazy var forgotPassword: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("forgot_password_button_title", comment: ""), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = Theme.Fonts.hyperlink
        return button
    }()
    
    // MARK: - Setups
    private func addSubviews() {
        addSubview(loginTextFieldBorder)
        loginTextFieldBorder.addSubview(loginTextField)
        loginTextFieldBorder.addSubview(emailIcon)
        
        addSubview(passwordTextFieldBorder)
        passwordTextFieldBorder.addSubview(passwordTextField)
        passwordTextFieldBorder.addSubview(passwordIcon)
        
        addSubview(forgotLogin)
        addSubview(forgotPassword)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // login text field border
            loginTextFieldBorder.topAnchor.constraint(equalTo: topAnchor, constant: Dimensions.textFieldTopMargin),
            loginTextFieldBorder.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Dimensions.margin),
            loginTextFieldBorder.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Dimensions.margin),
            loginTextFieldBorder.heightAnchor.constraint(equalToConstant: Dimensions.textFieldHeight),
            
            // login text field
            loginTextField.topAnchor.constraint(equalTo: loginTextFieldBorder.topAnchor, constant: Dimensions.margin),
            loginTextField.leadingAnchor.constraint(equalTo: loginTextFieldBorder.leadingAnchor, constant: Dimensions.margin),
            loginTextField.trailingAnchor.constraint(equalTo: emailIcon.leadingAnchor),
            loginTextField.bottomAnchor.constraint(equalTo: loginTextFieldBorder.bottomAnchor, constant: -Dimensions.margin),
            
            // login text field icon
            emailIcon.centerYAnchor.constraint(equalTo: loginTextFieldBorder.centerYAnchor),
            emailIcon.trailingAnchor.constraint(equalTo: loginTextFieldBorder.trailingAnchor, constant:  -Dimensions.margin),
            emailIcon.heightAnchor.constraint(equalToConstant: Dimensions.textFieldIconSizes),
            emailIcon.widthAnchor.constraint(equalToConstant: Dimensions.textFieldIconSizes),

            // password text field border
            passwordTextFieldBorder.topAnchor.constraint(equalTo: loginTextFieldBorder.bottomAnchor, constant: Dimensions.margin),
            passwordTextFieldBorder.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Dimensions.margin),
            passwordTextFieldBorder.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Dimensions.margin),
            passwordTextFieldBorder.heightAnchor.constraint(equalToConstant: Dimensions.textFieldHeight),
            
            // password text field
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldBorder.topAnchor, constant: Dimensions.margin),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldBorder.leadingAnchor, constant: Dimensions.margin),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordIcon.leadingAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldBorder.bottomAnchor, constant: -Dimensions.margin),
            
            // password text field icon
            passwordIcon.centerYAnchor.constraint(equalTo: passwordTextFieldBorder.centerYAnchor),
            passwordIcon.trailingAnchor.constraint(equalTo: passwordTextFieldBorder.trailingAnchor, constant:  -Dimensions.margin),
            passwordIcon.heightAnchor.constraint(equalToConstant: Dimensions.textFieldIconSizes),
            passwordIcon.widthAnchor.constraint(equalToConstant: Dimensions.textFieldIconSizes),
            
            // forgot login
            forgotLogin.topAnchor.constraint(equalTo: passwordTextFieldBorder.bottomAnchor, constant: Dimensions.margin),
            forgotLogin.leadingAnchor.constraint(equalTo: passwordTextFieldBorder.leadingAnchor, constant: Dimensions.usernameAndPasswordMargin),
            
            // forgot password
            forgotPassword.topAnchor.constraint(equalTo: passwordTextFieldBorder.bottomAnchor, constant: Dimensions.margin),
            forgotPassword.trailingAnchor.constraint(equalTo: passwordTextFieldBorder.trailingAnchor, constant: -Dimensions.usernameAndPasswordMargin),
            
            // view
            heightAnchor.constraint(equalToConstant: Dimensions.viewHeight)
        ])
    }
    
}
