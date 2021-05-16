//
//  LoginViewController.swift
//  FoodApp
//
//  Created by Alexandra Radu on 16.05.2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    @IBAction func loginBtn(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              !email.isEmpty && !password.isEmpty else {
            
            AlertManager.shared.showAlertManager(vc: self, message: "All fields are required.", handler: {
                print("All fields are required.")
            })
            
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                AlertManager.shared.showAlertManager(vc: self, message: error.localizedDescription, handler: {})
                return
            }
            
            guard let user = authDataResult?.user else {
                return
            }
            
            print(
                """
                        isAnonymous: \(user.isAnonymous),
                        isEmailVerified: \(user.isEmailVerified),
                        metadata: \(user.metadata),
                        multiFactor: \(user.multiFactor),
                        providerData: \(user.providerData),
                        providerID: \(user.providerID),
                        uid: \(user.uid),
                        description: \(user.description),
                    """
            )
            if user.isEmailVerified == true {
                AlertManager.shared.showAlertManager(vc: self, message: "Welcome", handler: {
                    print("Welcome")
                })
            } else {
                AlertManager.shared.showAlertManager(vc: self, message: "You need to check your confirmation email.", handler: {
                    print("Email not verifed")
                })
            }
        }
    }
    
    @IBAction func newAccountBtn(_ sender: Any) {
        let alertController = UIAlertController(title: "Register", message: "Create a new account", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Email"
            textField.isSecureTextEntry = false
        }
        alertController.addTextField {
            textField in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        }
        alertController.addTextField {
            textField in
            textField.placeholder = "Confirm Password"
            textField.isSecureTextEntry = true
        }
        
        let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
            
            guard let emailTF = alertController.textFields?.first, // [0]
                  let passwordTF = alertController.textFields?[1],
                  let confirmPasswordTF = alertController.textFields?.last else {
                print("It was not possible to take all textfields")
                return
            }
            
            guard let email = emailTF.text,
                  let password = passwordTF.text,
                  let confirmedPassword = confirmPasswordTF.text,
                  !email.isEmpty && !password.isEmpty && !confirmedPassword.isEmpty else {
                
                AlertManager.shared.showAlertManager(vc: self, message: "All fields are required.", handler: {
                    print("All fields are required.")
                })
                
                return
            }
            
            print("Current email \(email), password is \(password), confirmed password: \(confirmedPassword))")
            
            guard password == confirmedPassword else {
                AlertManager.shared.showAlertManager(vc: self, message: "Passwords are not equal.", handler: {
                    print("Passwords are not equal.")
                })
                
                return
            }
            
            print("Everything seems ok. let's create your account.")
            
            Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
                if let error = error {
                    AlertManager.shared.showAlertManager(vc: self, message: error.localizedDescription, handler: {})
                    return
                }
                
                guard let user = authDataResult?.user else {
                    return
                }
                
                print(
                    """
                            isAnonymous: \(user.isAnonymous),
                            isEmailVerified: \(user.isEmailVerified),
                            metadata: \(user.metadata),
                            multiFactor: \(user.multiFactor),
                            providerData: \(user.providerData),
                            providerID: \(user.providerID),
                            uid: \(user.uid),
                            description: \(user.description),
                        """
                )
                
                user.sendEmailVerification { (error) in
                    if let error = error {
                        AlertManager.shared.showAlertManager(vc: self, message: error.localizedDescription, handler: {})
                        return
                    }
                }
                
                AlertManager.shared.showAlertManager(vc: self, title: "Account created", message: "Please check your inbox and confirm in order to log in", handler: {})
            }
            
        }
        
        alertController.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
