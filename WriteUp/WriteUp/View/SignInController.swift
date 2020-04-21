//
//  ViewController.swift
//  WriteUp
//
//  Created by Ashwini shalke on 14/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
import AuthenticationServices


class SignInController: UIViewController, onBoardingViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemPink
        // Do any additional setup after loading the view.
        setupAutolayout()
    }
    
    let logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "AppLogo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        return logo
    }()
     
    
    let appleButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .white)
        button.layer.shadowColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleTapAppleButton), for: .touchUpInside)
        return button
    }()
    
  
    func setupAutolayout(){
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
                                     logoImageView.heightAnchor.constraint(equalToConstant: 200)])
        
        view.addSubview(appleButton)
        NSLayoutConstraint.activate([appleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
                                     appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                                     appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
                                     appleButton.heightAnchor.constraint(equalToConstant: 35)])
        
        
        
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
    
    
    func finishSignIn(sender : Any?){
        let onboarding = onBoarding()
        onboarding.delegate = self
        onboarding.defaultPresenatationStyle()
        present(onboarding, animated: true, completion: nil)
        UserDefaults.standard.setIsSignedIn(value: true)
    }
}


extension SignInController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
      print("Something is Wrong")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credential as ASAuthorizationAppleIDCredential :
            let user = User(credentials: credential)
            finishSignIn(sender: user)
          
        default:
            break
        }
    }
}


extension SignInController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    func showHome() {
                self.dismiss(animated: true){
                }
    }
}


