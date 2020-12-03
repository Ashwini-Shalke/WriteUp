//
//  SceneDelegate.swift
//  WriteUp
//
//  Created by Ashwini shalke on 14/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
import LocalAuthentication

class SceneDelegate: UIResponder, UIWindowSceneDelegate, errorLockDelegate{
    var window: UIWindow?
    let navigationController = UINavigationController(rootViewController: RootViewController())
    let editProfileDetail = EditProfileLauncher()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        let context = LAContext()
        var error: NSError?
        if UserDefaults.standard.isSignedIn() && UserDefaults.standard.isScreenLockedOn() {
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
            {
                let localizedReason = Constant.LocalAuth.localizedReason
                let lockScreen = WelcomeLockScreen()
                window?.rootViewController = lockScreen
                window?.makeKeyAndVisible()
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: localizedReason) {
                    [weak self] success, authenticationError in
                    DispatchQueue.main.async {
                        if success {
                            self?.window?.rootViewController = self?.navigationController
                            self?.window?.makeKeyAndVisible()
                        } else {
                            let errorScreen = ErrorLockScreen()
                            errorScreen.successScreenDelegate = self
                            self?.window?.rootViewController = errorScreen
                            self?.window?.makeKeyAndVisible()
                        }
                    }
                }
            } else {
                let ac = UIAlertController(title: Constant.LocalAuth.alertTitle, message: Constant.LocalAuth.alertMessage, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
            }
        }
    }
    
    func handleSuccessScreen() {
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
    }
}




