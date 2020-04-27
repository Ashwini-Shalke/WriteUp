//
//  RootViewController.swift
//  WriteUp
//
//  Created by Ashwini shalke on 21/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit


class RootViewController: UIViewController,signInProtocol{
    
    lazy var signInController : SignInController = {
        var sc = SignInController()
        sc.rootViewController = self
        return sc
    }()
    
 
    let homeController = HomeController()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.green
        handleChild()
    }
    
    fileprivate func isSignedIn() -> Bool {
        return UserDefaults.standard.isSignedIn()
       
    }
    
    func handleChild(){
        if isSignedIn() {
            if children == [signInController] {
                signInController.remove()
            }
            self.addChild(homeController)
            setupLayout(homeController)
        } else {
            if children == [homeController] {
                homeController.remove()
            }
            self.addChild(signInController)
            
            setupLayout(signInController)
        }
    }
    
    func handleRoot() {
        handleChild()
    }
}

extension RootViewController{
    func setupLayout(_ child: UIViewController){
        self.view.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            child.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            child.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            child.view.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
}
