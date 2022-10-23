//
//  Coordinator.swift
//  SignUp&ImageCache
//
//  Created by fyz on 6/15/22.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}
