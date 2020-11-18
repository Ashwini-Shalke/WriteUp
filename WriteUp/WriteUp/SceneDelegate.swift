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
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        let context = LAContext()
        var error: NSError?
        //        UserDefaults.standard.isSignedIn() &&
        if UserDefaults.standard.isSignedIn() && editProfileDetail.profileDetail.screenLockSwitch.isOn == false {
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
            {
                var localizedReason = "Unlock device"
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
                let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
            } }
    }
    
    
    func handleSuccessScreen() {
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
    }
}




