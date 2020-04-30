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
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 0)
        button.layer.cornerRadius = button.frame.width/2
        button.backgroundColor = UIColor.systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.titleLabel?.font = UIFont().boldSystemFont()
        return button
    }()
    
    @objc func handleSignOut(){
        UserDefaults.standard.setIsSignedIn(value: false)
        let profileLauncher = ProfileLauncher()
        navigationController?.pushViewController(profileLauncher, animated: true)
    }
    
    let barlabel: UILabel = {
        let label = UILabel()
        label.text = Constant.HomeSC.barLabel
        label.font = UIFont().appNavFont()
        label.textColor = UIColor.systemPink
        return label
    }()
    
    func setupLayout(){
        barlabel.frame = CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height)
        navigationController?.navigationBar.topItem?.titleView = barlabel
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
       
       
        profileButton.addTarget(self, action: #selector(handleSignOut), for: UIControl.Event.touchUpInside)
        profileButton.addTarget(self, action: #selector(handleSignOut), for: UIControl.Event.touchUpInside)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        
        setupLayout()
    }
    
}


