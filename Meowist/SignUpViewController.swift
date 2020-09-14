//
//  SignUpViewController.swift
//  Meowist
//
//  Created by bhrs on 9/13/20.
//  Copyright © 2020 Blake. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
    }

}

extension SignUpViewController {
    
    func signUpUser() {
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = ""
        changeRequest?.photoURL = URL(string: "https://images-na.ssl-images-amazon.com/images/I/71y8Hdi9ueL._AC_SY606_.jpg")
        changeRequest?.commitChanges { (error) in
          // ...
        }
        
        //        // TODO: Add view related info
        //        guard let email = loginCredentialsView.loginTextField.text, let password = loginCredentialsView.passwordTextField.text else { return }
        //        showLoadingIndicator()
        //        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
        //            self.hideLoadingIndicator()
        //            guard error == nil else {
        //                self.presentAlert(with: NSLocalizedString("general_alert_title", comment: ""), description: error?.localizedDescription)
        //                return
        //            }
        //            self.presentAlert(with: NSLocalizedString("success_alert_title", comment: ""), description: result?.user.email)
        //        }
    }
}
