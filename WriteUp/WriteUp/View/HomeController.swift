//
//  Home.swift
//  WriteUp
//
//  Created by Ashwini shalke on 14/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
   private let profileButton : UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("SIGNOUT", for: .normal)
         button.setTitleColor(UIColor.mainPink, for: .normal)
         button.translatesAutoresizingMaskIntoConstraints = false
         button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
         button.addTarget(self, action: #selector(handleSignOut), for: UIControl.Event.touchUpInside)
         return button
     }()
    
    @objc func handleSignOut(){
        UserDefaults.standard.setIsSignedIn(value: false)
        let signInController = SignInController()
        signInController.defaultPresenatationStyle()
       present(signInController, animated: true, completion: nil)
    }
    
    func setLayout(){
        view.addSubview(profileButton)
        NSLayoutConstraint.activate([
            profileButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            profileButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            profileButton.widthAnchor.constraint(equalToConstant: 200)])
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        
        setLayout()
       
    }
    
    
}


