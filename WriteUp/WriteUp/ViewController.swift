//
//  ViewController.swift
//  WriteUp
//
//  Created by Ashwini shalke on 14/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        setUpSignInButton()
    }
    
    
    func setUpSignInButton(){
        let appleButton = ASAuthorizationAppleIDButton(type: .default, style: .whiteOutline)
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(appleButton)
        NSLayoutConstraint.activate([appleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 300),
                                     appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)])
        
        appleButton.addTarget(self, action: #selector(handleTapAppleButton), for: .touchUpInside)
        
    }
    
    
    @objc func handleTapAppleButton(){
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
        
//        self.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
    }
    
    
   
    
}


extension ViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
      print("Something is Wrong")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
         
        switch authorization.credential {
        case let credential as ASAuthorizationAppleIDCredential :
            let user = User(credentials: credential)
            performSegue(withIdentifier: "segue", sender: user)
            
        default:
            break
        }
    }
}

extension ViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    
}


