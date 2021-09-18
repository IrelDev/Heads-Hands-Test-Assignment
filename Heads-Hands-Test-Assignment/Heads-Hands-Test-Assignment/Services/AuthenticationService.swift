//
//  AuthenticationService.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 16.09.2021.
//

import Foundation
import VKSdkFramework

class AuthenticationService: NSObject {
    private let applicationIdentifier = "7952605"
    private let vkSdk: VKSdk
    
    weak var delegate: AuthenticationServiceDelegate?
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: applicationIdentifier)
        
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        let permissions = ["offline", "wall", "friends", "video"]
        
        VKSdk.wakeUpSession(permissions, complete: { (state, error) in
            switch state {
            case .initialized:
                VKSdk.authorize(permissions)
            case .authorized:
                self.delegate?.authenticationSucceeded()
            default:
                self.delegate?.authenticationFailed()
            }
        })
    }
}
extension AuthenticationService: VKSdkDelegate, VKSdkUIDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            delegate?.authenticationSucceeded()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        delegate?.authenticationFailed()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.shouldShowViewController(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        let alert = UIAlertController(title: "Error", message: "Captcha required", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        SceneDelegate.getTopMostViewController()?.present(alert, animated: true, completion: nil)
    }
}
