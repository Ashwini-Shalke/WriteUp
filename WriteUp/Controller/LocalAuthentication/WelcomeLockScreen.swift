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
        view.backgroundColor = UIColor.white
    }
    
    @objc func handlePressMe() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
        {
            let localizedReason = Constant.LocalAuth.localizedReason
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: localizedReason) {
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
