//
//  MainNavigationalController.swift
//  WriteUp
//
//  Created by Ashwini shalke on 15/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

//import UIKit
//
//class MainNavigationalController: UINavigationController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor.red
//        handleUserFlow()
//    }
//    
//    fileprivate func isSignedIn() -> Bool {
//        return UserDefaults.standard.isSignedIn()
//    }
//    
//    @objc func showSignInController(){
//        let signinController =  SignInController()
//        signinController.defaultPresenatationStyle()
//        present(signinController, animated: true, completion: nil)
//    }
//    
//    
//    func handleUserFlow() {
//        let homeController = HomeController()
//        viewControllers = [homeController]
//        UserDefaults.standard.synchronize()
//        if !isSignedIn(){
//            perform(#selector(showSignInController), with: nil, afterDelay: 0.01)
//        }
//    }
//    
//    
//}
//
//
//
