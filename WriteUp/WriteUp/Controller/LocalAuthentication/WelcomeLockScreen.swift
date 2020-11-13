//
//  WelcomeLockScreen.swift
//  WriteUp
//
//  Created by Ashwini shalke on 05/11/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//
import UIKit
import LocalAuthentication

class WelcomeLockScreen: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    @objc func handlePressMe() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
        {
            let reason = "Touch ID is required to use WriteUp"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {
                [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self!.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
}
