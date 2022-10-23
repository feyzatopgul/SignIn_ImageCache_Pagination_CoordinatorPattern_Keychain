//
//  SignUpViewController.swift
//  SignUp&ImageCache
//
//  Created by fyz on 6/14/22.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import RealmSwift

class SignUpViewController: UIViewController, Storyboarded {

    weak var coordinator: MainCoordinator?
    var viewModel = SignInViewModel()
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        viewModel.signUp(firstName: firstNameField.text, lastName: lastNameField.text, email: emailField.text, password: passwordField.text) { error in
            guard error == nil else {
                let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            self.coordinator?.homeScreen()
        }
    }
    
    @IBAction func signedInButton(_ sender: Any) {
        coordinator?.start()
    }
}
