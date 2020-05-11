//
//  ViewController.swift
//  WriteUp
//
//  Created by Ashwini shalke on 14/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
import AuthenticationServices

protocol signInDelegate{
    func handleRoot()
}

class SignInViewController: UIViewController,onBoardingViewControllerDelegate {
    var signInDelegate: signInDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemPink
        setupAutolayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    let logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: Constant.SignInSC.logoImageName)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    let appleButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .white)
        button.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleTapAppleButton), for: .touchUpInside)
        return button
    }()
    
    func setupAutolayout(){
        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 199, left: 69, bottom: -199, right: -69))
      
        view.addSubview(appleButton)
        appleButton.anchor(top: logoImageView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil,trailing: view.safeAreaLayoutGuide.trailingAnchor, padding:  UIEdgeInsets(top: 131, left: 28, bottom: 0, right: -28), size: CGSize(width: 0, height: 44))
    }
    
    @objc func handleTapAppleButton(){
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    func launchOnboard(sender : Any?){
        let onboarding = onBoardingController()
        onboarding.onboardingdelegate = self
        onboarding.defaultPresenatationStyle()
        present(onboarding, animated: true, completion: nil)
        UserDefaults.standard.setIsSignedIn(value: true)
    }
}

extension SignInViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Something is Wrong")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credential as ASAuthorizationAppleIDCredential :
            let user = User(credentials: credential)
            launchOnboard(sender: user)
        default:
            break
        }
    }
}

extension SignInViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    func dismissSignIn() {
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut, animations: {
            self.dismiss(animated: false, completion: nil)
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 1, options: .curveLinear, animations: {
            self.signInDelegate?.handleRoot()
        }, completion: nil)
    }
}


