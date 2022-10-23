//
//  SignInViewController.swift
//  SignUp&ImageCache
//
//  Created by fyz on 6/14/22.
//

import UIKit
import FBSDKLoginKit

class SignInViewController: UIViewController, Storyboarded, LoginButtonDelegate {
    
    weak var coordinator: MainCoordinator?
    var viewModel = SignInViewModel()
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    let fBLoginButton: FBLoginButton = {
        let button = FBLoginButton()
        button.permissions = ["email", "public_profile"]
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        fBLoginButton.center = view.center
        fBLoginButton.delegate = self
        view.addSubview(fBLoginButton)
        
    }
    

    @IBAction func signInButton(_ sender: Any) {
        viewModel.signIn(email: emailField.text, password: passwordField.text) { error in
            guard error == nil else {
                let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            //User is successfully signed in go to home screen
            self.coordinator?.homeScreen()
        }
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        self.coordinator?.signUpScreen()
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard let token = AccessToken.current?.tokenString else {
            return
        }
        print("Token: \(token)")
        viewModel.fBSignIn(token: token) { error in
            guard error == nil else {
                let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.coordinator?.homeScreen()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        //no operation
    }
    
    
}
