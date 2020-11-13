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
        let attributedText = NSMutableAttributedString(string: "WriteUp Locked", attributes : [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)])
        attributedText.append(NSAttributedString(string: "\n\nUnlock with TouchId to open WriteUp", attributes : [NSAttributedString.Key.font
            : UIFont.systemFont(ofSize: 18)]))
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let pressMeButton: UIButton = {
        let pressMeButton = UIButton()
        pressMeButton.translatesAutoresizingMaskIntoConstraints = false
        pressMeButton.setTitle("Use Touch ID", for: .normal)
        pressMeButton.setTitleColor(.systemBlue, for: .normal)
        pressMeButton.addTarget(self, action: #selector(handlePressMe), for: .touchUpInside)
        return pressMeButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubview(descriptionTextView)
        NSLayoutConstraint.activate([
            descriptionTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            descriptionTextView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)])
        self.view.addSubview(pressMeButton)
        NSLayoutConstraint.activate([
            pressMeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            pressMeButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant : 30)])
    }
    
    @objc func handlePressMe() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
        {
            let reason = "Touch ID for appName"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {
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
