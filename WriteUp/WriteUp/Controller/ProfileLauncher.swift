//
//  ProfileLauncher.swift
//  WriteUp
//
//  Created by Ashwini shalke on 21/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

protocol ProfileLauncherDelegate: AnyObject {
    func dismissHome()
}

class ProfileLauncher: UIViewController {
    weak var profileDelegate: ProfileLauncherDelegate?
    let stackHeight = CGSize(width: 0, height: (32 * 4) + (37 * 4) + 4)
    
    func autolayout() {
        let signOutButton = PrimaryButton(titleText: Constant.ProfileSC.signOutButtonTitle)
        signOutButton.addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
        
        view.addSubview(signOutButton)
        signOutButton.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: -30, right: -16), size: CGSize(width: 0, height: 44))
        
        let profileDetail = ProfileDetail()
        view.addSubview(profileDetail)
        profileDetail.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: -100, right: 0))
    }
    
    @objc func handleSignOut(){
        self.navigationController?.popViewController(animated: false)
        profileDelegate?.dismissHome()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = Constant.ProfileSC.navTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEdit))
        
        autolayout()
    }
    
    @objc func handleEdit(){
        let editProfileLauncher = EditProfileLauncher()
        let navController = UINavigationController(rootViewController: editProfileLauncher)
        self.present(navController, animated: true, completion: nil)
        
    }
}

