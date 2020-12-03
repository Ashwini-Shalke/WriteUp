//
//  ErrorLockScreen.swift
//  WriteUp
//
//  Created by Ashwini shalke on 05/11/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//
import UIKit
import LocalAuthentication

protocol errorLockDelegate: AnyObject {
    func handleSuccessScreen()
}

class ErrorLockScreen: UIViewController {
    weak var successScreenDelegate: errorLockDelegate?
    let window = UIWindow()
    
    let descriptionTextView: UITextView = {
        let textView =  UITextView()
        let text:String
        let attributedText = NSMutableAttributedString(string: Constant.LocalAuth.errorAttributedString, attributes : [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 27)])
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let unlockButton: UIButton = {
        let unlockButton = UIButton()
        unlockButton.translatesAutoresizingMaskIntoConstraints = false
        unlockButton.setTitle(Constant.LocalAuth.localizedReason, for: .normal)
        unlockButton.setTitleColor(.systemBlue, for: .normal)
        unlockButton.addTarget(self, action: #selector(handlePressMe), for: .touchUpInside)
        return unlockButton 
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubview(descriptionTextView)
        NSLayoutConstraint.activate([
            descriptionTextView.centerXAnchor.constraint(equalTo:self.view.centerXAnchor),
            descriptionTextView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: -75)])
        self.view.addSubview(unlockButton)
        NSLayoutConstraint.activate([
            unlockButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            unlockButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant : 15)])
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
                        self?.dismiss(animated: true, completion: nil)
                        self?.successScreenDelegate?.handleSuccessScreen()
                    }
                }
            }
        }
    }
}
