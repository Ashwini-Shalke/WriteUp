//
//  Home.swift
//  WriteUp
//
//  Created by Ashwini shalke on 14/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    var user: User?
    
    var homeView: UIView = {
        let home = UIView()
        home.backgroundColor = UIColor.yellow
        home.translatesAutoresizingMaskIntoConstraints = false
        return home
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
        view.addSubview(homeView)
    }
    
    @objc func handleSignOut(){
        UserDefaults.standard.setIsSignedIn(value: false)
        let signInController = SignInController()
        signInController.defaultPresenatationStyle()
        present(signInController, animated: true, completion: nil)
    }
    
    
    
    
}
