//
//  LoginViewController.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 15.09.2021.
//

import UIKit

class LoginViewController: UIViewController {
    let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}

