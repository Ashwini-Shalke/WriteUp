//
//  RootViewController.swift
//  WriteUp
//
//  Created by Ashwini shalke on 21/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//
import UIKit

class RootViewController: UIViewController,signInDelegate,homeDelegate{
   
    lazy var homeViewController: HomeViewController = {
        var hc = HomeViewController()
        hc.homeDelegate = self
        return hc
    }()
       
    lazy var signinViewController : SignInViewController = {
        var sc = SignInViewController()
        sc.signInDelegate = self
        return sc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        handleChild()
    }
 
    fileprivate func isSignedIn() -> Bool {
        return UserDefaults.standard.isSignedIn()
    }
    
    func handleChild(){
        if isSignedIn() {
            if children == [signinViewController] {
                signinViewController.remove()
            }
            self.addChild(homeViewController)
            setupLayout(homeViewController)
        } else {
            if children == [homeViewController] {
                homeViewController.remove()
            }
            self.addChild(signinViewController)
            setupLayout(signinViewController)
        }
    }
    
    func handleRoot(){
        handleChild()
    }
    
    func handleSignOut(){
       handleChild()
    }
}

extension RootViewController {
    func setupLayout(_ child: UIViewController){
        self.view.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            child.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            child.view.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
}
