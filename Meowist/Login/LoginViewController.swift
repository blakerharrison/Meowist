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
        static let bottomMargin: CGFloat = 5
        static let buttonHeight: CGFloat = 50
        static let activityIndicatorHeightAndWidth: CGFloat = 100
        static let topMargin: CGFloat = 50
    }
    
    // MARK: - Views
    private let headerView = LoginHeaderView()
    private let loginCredentialsView = LoginCredentialsView()
    
    lazy var signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("sign_in_button_title", comment: ""), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 25
        button.backgroundColor = Theme.Colors.secondary
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(signInTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("sign_up_button_title", comment: ""), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(signUpTapped(_:)), for: .touchUpInside)
        button.titleLabel?.font = Theme.Fonts.hyperlink
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
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupConstraints()
        setupDelegates()
        addTargets()
    }
    
    // MARK: - Setups
    private func setupView() {
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard (_:))))
    }
    
    private func addSubviews() {
        let subviews = [headerView, loginCredentialsView,
                        signInButton,signUpButton]
        subviews.forEach { view.addSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // header
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Dimensions.topMargin),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Dimensions.margin),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Dimensions.margin),
            
            // login credentials
            loginCredentialsView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            loginCredentialsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Dimensions.margin),
            loginCredentialsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Dimensions.margin),
            
            // sign in button
            signInButton.topAnchor.constraint(equalTo: loginCredentialsView.bottomAnchor, constant: 40),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Dimensions.margin),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Dimensions.margin),
            signInButton.heightAnchor.constraint(equalToConstant: Dimensions.buttonHeight),
            
            // sign up button
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: Dimensions.buttonHeight),
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant:
                                                    Dimensions.bottomMargin)
        ])
    }
    
    private func setupDelegates() {
        loginCredentialsView.loginTextField.delegate = self
        loginCredentialsView.passwordTextField.delegate = self
    }
    
    private func addTargets() {
        loginCredentialsView.forgotLogin.addTarget(self, action: #selector(forgotLoginTapped(_:)), for: .touchUpInside)
        loginCredentialsView.forgotPassword.addTarget(self, action: #selector(forgotPasswordTapped(_:)), for: .touchUpInside)
    }
    
}

// MARK: - Actions
extension LoginViewController {
    
    @objc private func signInTapped(_ sender: UIButton) {
        signIn()
    }
    
    @objc private func signUpTapped(_ sender: UIButton) {
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }

    @objc private func forgotLoginTapped(_ sender: UIButton) {
        presentAlert(with: NSLocalizedString("coming_soon_alert_title", comment: ""))
    }
    
    @objc private func forgotPasswordTapped(_ sender: UIButton) {
        presentAlert(with: NSLocalizedString("coming_soon_alert_title", comment: ""))
    }

    @objc private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        loginCredentialsView.loginTextField.resignFirstResponder()
        loginCredentialsView.passwordTextField.resignFirstResponder()
    }
    
}

// MARK: TextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginCredentialsView.loginTextField {
            loginCredentialsView.passwordTextField.becomeFirstResponder()
        } else {
            loginCredentialsView.passwordTextField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - Private
extension LoginViewController {
    
    private func signIn() {
        guard let email = loginCredentialsView.loginTextField.text, let password = loginCredentialsView.passwordTextField.text else { return }
        showLoadingIndicator()
        Auth.auth().signIn(withEmail: email, password: password, completion:  { result, error in
            self.hideLoadingIndicator()
            guard error == nil else {
                self.presentAlert(with: NSLocalizedString("general_alert_title", comment: ""), description: error?.localizedDescription ?? "")
                return
            }
            self.presentAlert(with: NSLocalizedString("success_alert_title", comment: ""), description: result?.user.email ?? "")
        })
    }
    
    private func presentAlert(with title: String, description: String? = "") {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok_button_text", comment: ""), style: .default, handler: nil))
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
