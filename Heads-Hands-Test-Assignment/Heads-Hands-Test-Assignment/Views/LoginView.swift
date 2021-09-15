//
//  LoginView.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 15.09.2021.
//

import UIKit

class LoginView: UIView {
    lazy var loginButton: UIButton = {
        let loginButton = UIButton(type: .system)
        
        loginButton.layer.cornerRadius = 7
        loginButton.clipsToBounds = true
        
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("Войти", for: .normal)
        loginButton.backgroundColor = .systemBlue
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        return loginButton
    }()
    init() {
        super.init(frame: .zero)

        setupViews()
        setupNSLayoutConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension LoginView {
    func setupViews() {
        backgroundColor = .systemBackground
        
        addSubview(loginButton)
    }
    
    func setupNSLayoutConstraints() {
        let widthConstraint = loginButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7)
        
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 44),
            loginButton.widthAnchor.constraint(lessThanOrEqualToConstant: 320),
            widthConstraint,
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
