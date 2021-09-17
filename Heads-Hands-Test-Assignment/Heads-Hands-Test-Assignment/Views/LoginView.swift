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
        
        loginButton.layer.cornerRadius = UIConstants.buttonCornerRadius
        loginButton.clipsToBounds = true
        
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor(named: "AccentColor")
        
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
        let widthConstraint = loginButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        widthConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: UIConstants.buttonHeight),
            loginButton.widthAnchor.constraint(lessThanOrEqualToConstant: 320), // iPad & landscape mode
            widthConstraint,
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
