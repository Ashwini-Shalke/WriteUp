//
//  AddNewNote.swift
//  WriteUp
//
//  Created by Ashwini shalke on 20/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class AddNewNoteController: UIViewController {
    
    let textView: UITextView = {
        let textview = UITextView()
        textview.isEditable = true
        textview.font = UIFont.systemFont(ofSize: 20)
        return textview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleNewNote))
        
        view.addSubview(textView)
        
        textView.backgroundColor = .green
        textView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0 , right: -16), size: CGSize(width: 0, height: 300))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleNewNote(){
        self.view.endEditing(true)
       
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keybardFrame = keyboardSize.cgRectValue
        let keyboardYaxis = self.view.frame.size.height - keybardFrame.height
        print("keyboardhieght", keyboardYaxis)
        
        let editTextFieldY: CGFloat = textView.frame.maxY
        print("textView maxY", editTextFieldY)
        if self.view.frame.origin.y >= 0 {
            if editTextFieldY > keyboardYaxis {
                UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    self.textView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: -keybardFrame.height - 50 , right: -16))
                }, completion: nil)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
       UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.textView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: -16 , right: -16))
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension AddNewNoteController: UITextViewDelegate {
}
