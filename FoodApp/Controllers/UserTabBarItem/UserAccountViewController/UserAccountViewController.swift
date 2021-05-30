//
//  UserAccountViewController.swift
//  FoodApp
//
//  Created by Alexandra Radu on 16.05.2021.
//

import UIKit
import Firebase

class UserAccountViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var loginUserStackView: UIStackView!
    @IBOutlet weak var welcomingLbl: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
    
    // MARK: - Variables
    var userIsLoggedIn: Bool = false
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    // MARK: - IBActions
    @IBAction func loginBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToLoginScreen", sender: nil)
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            PersistenceService.sharedInstance.deleteEntity(named: String(describing: FoodEntity.self))
        } catch let error {
            AlertManager.shared.showAlertManager(vc: self, message: error.localizedDescription, handler: {
                print("Error signing out: %@", error)
            })
        }
    }
    
    // MARK: - VC Methods
    func setupScreen() {
        addAutentiationListeners()
    }
    
    func addAutentiationListeners() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            guard let user = user else {
                self.loginUserStackView.isHidden = false
                self.welcomingLbl.text = "Hello!"
                self.logoutBtn.isHidden = true
                return
            }
            self.loginUserStackView.isHidden = true
            self.logoutBtn.isHidden = false
            
            guard let email = user.email else {
                self.welcomingLbl.text = "Hello!"
                return
            }
            
            self.welcomingLbl.text = "Hello, \(email)!"
        }
    }
}
