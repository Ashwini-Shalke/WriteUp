//
//  Home.swift
//  WriteUp
//
//  Created by Ashwini shalke on 14/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

protocol homeDelegate {
    func handleSignOut()
}

class HomeViewController: UIViewController, ProfileLauncherDelegate{
    var homeDelegate : homeDelegate?
    
    let notesBar:NotesBar = {
       let nb = NotesBar()
        nb.translatesAutoresizingMaskIntoConstraints = false
//        nb.backgroundColor = .green
        return nb
    }()
    
    
    private let profileButton : UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 0)
        button.layer.cornerRadius = button.frame.width/2
        button.backgroundColor = UIColor.systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func handleProfileButton(){
        let profileLauncher = ProfileLauncher()
        profileLauncher.profiledelegate = self
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
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
        profileButton.addTarget(self, action: #selector(handleProfileButton), for: UIControl.Event.touchUpInside)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        view.addSubview(notesBar)
        notesBar.anchor(top:view.safeAreaLayoutGuide.topAnchor,leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16),size: CGSize(width: 0, height: 205))
        setupLayout()
    }
    
    func dismissHome() {
        UserDefaults.standard.setIsSignedIn(value: false)
        self.homeDelegate?.handleSignOut()
    }
}


