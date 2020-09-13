//
//  ViewController.swift
//  Meowist
//
//  Created by bhrs on 9/12/20.
//  Copyright © 2020 Blake. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    // MARK: - Dimensions
    private struct Dimensions {
        static let margin: CGFloat = 16
        static let textFieldTopMargin: CGFloat = 175
        static let textFieldHeight: CGFloat = 65
        static let textFieldToButtonSpacing: CGFloat = 35
        static let textFieldContainerMargin: CGFloat = 10
        static let bottomMargin: CGFloat = 250
        static let buttonHeight: CGFloat = 50
        static let activityIndicatorHeightAndWidth: CGFloat = 100
    }
    
    // MARK: - Views
    lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.backgroundColor = .clear
        textField.returnKeyType = .next
        textField.keyboardType = .emailAddress
        textField.delegate = self
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.backgroundColor = .clear
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        textField.delegate = self
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
    
    lazy var signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.addTarget(self, action: #selector(signIn(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(signUp(_:)), for: .touchUpInside)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        return button
    }()
    
    private lazy var loadingIndicator = CustomLoadingIndicatorView(
        frame: CGRect(
            x: view.center.x - (Dimensions.activityIndicatorHeightAndWidth / 2),
            y: view.center.y - (Dimensions.activityIndicatorHeightAndWidth),
            width: Dimensions.activityIndicatorHeightAndWidth,
            height: Dimensions.activityIndicatorHeightAndWidth),
        image: UIImage(named: "customLoader") // TODO: Replace with custom image
    )

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        setupConstraints()
    }
    
    // MARK: - Setups
    private func addSubviews() {
        view.addSubview(loginTextFieldBorder)
        loginTextFieldBorder.addSubview(loginTextField)
        view.addSubview(passwordTextFieldBorder)
        passwordTextFieldBorder.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // login text field border
            loginTextFieldBorder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Dimensions.textFieldTopMargin),
            loginTextFieldBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Dimensions.margin),
            loginTextFieldBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Dimensions.margin),
            loginTextFieldBorder.heightAnchor.constraint(equalToConstant: Dimensions.textFieldHeight),
            
            // login text field
            loginTextField.topAnchor.constraint(equalTo: loginTextFieldBorder.topAnchor, constant: Dimensions.margin),
            loginTextField.leadingAnchor.constraint(equalTo: loginTextFieldBorder.leadingAnchor, constant: Dimensions.margin),
            loginTextField.trailingAnchor.constraint(equalTo: loginTextFieldBorder.trailingAnchor, constant: -Dimensions.margin),
            loginTextField.bottomAnchor.constraint(equalTo: loginTextFieldBorder.bottomAnchor, constant: -Dimensions.margin),
            
            // password text field border
            passwordTextFieldBorder.topAnchor.constraint(equalTo: loginTextFieldBorder.bottomAnchor, constant: Dimensions.margin),
            passwordTextFieldBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Dimensions.margin),
            passwordTextFieldBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Dimensions.margin),
            passwordTextFieldBorder.heightAnchor.constraint(equalToConstant: Dimensions.textFieldHeight),
            
            // password text field
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldBorder.topAnchor, constant: Dimensions.margin),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldBorder.leadingAnchor, constant: Dimensions.margin),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordTextFieldBorder.trailingAnchor, constant: -Dimensions.margin),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldBorder.bottomAnchor, constant: -Dimensions.margin),
            
            // sign in button
            signInButton.topAnchor.constraint(equalTo: passwordTextFieldBorder.bottomAnchor, constant: Dimensions.textFieldToButtonSpacing),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Dimensions.margin),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Dimensions.margin),
            signInButton.heightAnchor.constraint(equalToConstant: Dimensions.buttonHeight),
            
            // sign up button
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: Dimensions.margin),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Dimensions.margin),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Dimensions.margin),
//            signUpButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Dimensions.bottomMargin),
            signUpButton.heightAnchor.constraint(equalToConstant: Dimensions.buttonHeight)
        ])
    }
    
}

// MARK: - Actions
extension LoginViewController {
    
     @objc private func signIn(_ sender: UIButton) {
        guard let email = loginTextField.text, let password = passwordTextField.text else { return }
        showLoadingIndicator()
        Auth.auth().signIn(withEmail: email, password: password, completion:  { result, error in
            self.hideLoadingIndicator()
            guard error == nil else {
                self.presentAlert(with: "Something when wrong", description: error?.localizedDescription ?? "")
                return
            }
            self.presentAlert(with: "Success", description: result?.user.email ?? "")
        })
    }
    
    @objc private func signUp(_ sender: UIButton) {
        guard let email = loginTextField.text, let password = passwordTextField.text else { return }
        showLoadingIndicator()
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            self.hideLoadingIndicator()
            guard error == nil else {
                self.presentAlert(with: "Something when wrong", description: error?.localizedDescription ?? "")
                return
            }
            self.presentAlert(with: "Success", description: result?.user.email ?? "")
        }
    }
    
}

// MARK: TextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - Private
extension LoginViewController {
    
    private func presentAlert(with title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showLoadingIndicator() {
        view.isUserInteractionEnabled = false
        view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        loadingIndicator.removeFromSuperview()
        view.isUserInteractionEnabled = true
    }
    
}
