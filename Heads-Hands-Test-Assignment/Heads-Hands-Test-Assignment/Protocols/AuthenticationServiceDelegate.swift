//
//  AuthServiceDelegate.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 16.09.2021.
//

import UIKit

protocol AuthenticationServiceDelegate: AnyObject {
    func authenticationSucceeded()
    func authenticationFailed()
    
    func shouldShowViewController(viewController: UIViewController)
}
