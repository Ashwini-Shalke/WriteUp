//
//  MainNavigationalController.swift
//  WriteUp
//
//  Created by Ashwini shalke on 15/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class MainNavigationalController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        
        if isSignedIn(){
            let homeController = HomeController()
            viewControllers = [homeController]
//            present(homeController, animated: true, completion: nil)
            UserDefaults.standard.synchronize()
        } else {
            perform(#selector(showSignInController), with: nil, afterDelay: 0.01)
        }
    }
    
    fileprivate func isSignedIn() -> Bool {
        return UserDefaults.standard.isSignedIn()
    }
    
    @objc func showSignInController(){
        let signinController =  SignInController()
        signinController.defaultPresenatationStyle()
        present(signinController, animated: true) {
        }
    }
    
    
}



