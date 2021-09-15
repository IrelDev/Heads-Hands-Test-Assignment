//
//  ApplicationCoordinator.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 15.09.2021.
//

import UIKit

struct ApplicationCoordinator {
    var window: UIWindow?
        
    init(window: UIWindow) {
        self.window = window
    }
    func startApplication() {
        let launchViewController = LoginViewController()
        
        window?.rootViewController = launchViewController
        window?.makeKeyAndVisible()
    }
}
