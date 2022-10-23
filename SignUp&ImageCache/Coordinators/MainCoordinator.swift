//
//  MainCoordinator.swift
//  SignUp&ImageCache
//
//  Created by fyz on 6/15/22.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    func signUpScreen() {
        let vc = SignUpViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    func start() {
        let vc = SignInViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    func homeScreen(){
        let vc = HomeViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
