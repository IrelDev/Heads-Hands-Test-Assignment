//
//  LoginViewController.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 15.09.2021.
//

import UIKit

class LoginViewController: UIViewController {
    private let loginView = LoginView()
    private lazy var authenticationService = AuthenticationService()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTargets()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
        
    func setupTargets() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        authenticationService.delegate = self
    }
    @objc func loginButtonTapped() {
        authenticationService.wakeUpSession()
    }
}

extension LoginViewController: AuthenticationServiceDelegate {
    func authenticationSucceeded() {
        let newsFeedViewController = NewsFeedViewController()
        navigationController?.setViewControllers([newsFeedViewController], animated: true)
    }
    func authenticationFailed() {
        let alert = UIAlertController(title: "Error", message: "Authentication Failed", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func shouldShowViewController(viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
    }
}
