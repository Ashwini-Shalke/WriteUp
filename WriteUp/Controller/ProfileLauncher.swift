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
    let profileDetail = ProfileDetail()
    let stackHeight = CGSize(width: 0, height: (32 * 4) + (37 * 4) + 4)
    let signOutButton = PrimaryButton(titleText: Constant.ProfileSC.signOutButtonTitle)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autolayout()
        handleScreenLock()
    }
    
    func autolayout() {
        view.backgroundColor = UIColor.white
        navigationItem.title = Constant.ProfileSC.navTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEdit))
        
        view.addSubview(profileDetail)
        profileDetail.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: -100, right: 0))
        profileDetail.screenLockSwitch.addTarget(self, action: #selector(setScreenLocked), for: .valueChanged)
        
        view.addSubview(signOutButton)
        signOutButton.anchor(top: profileDetail.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top:30, left: 16, bottom: -30, right: -16), size: CGSize(width: 0, height: 0))
        signOutButton.addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
    }
    
    @objc func handleSignOut(){
        self.navigationController?.popViewController(animated: false)
        profileDelegate?.dismissHome()
    }
    
    @objc func handleEdit(){
        let editProfileLauncher = EditProfileLauncher()
        let navController = UINavigationController(rootViewController: editProfileLauncher)
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func setScreenLocked() {
        profileDetail.screenLockSwitch.isOn ? UserDefaults.standard.setIsScreenLockedOn(value: true) : UserDefaults.standard.setIsScreenLockedOn(value: false)
    }
    
    fileprivate func isScreenLocked() -> Bool {
        return UserDefaults.standard.isScreenLockedOn()
    }
    
    func handleScreenLock(){
        if isScreenLocked() {
            profileDetail.screenLockSwitch.isOn = true
        } else {
            profileDetail.screenLockSwitch.isOn = false
        }
    }
}
