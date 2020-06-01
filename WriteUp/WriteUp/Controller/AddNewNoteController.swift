//
//  AddNewNote.swift
//  WriteUp
//
//  Created by Ashwini shalke on 20/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class AddNewNoteController: UIViewController {

    
    
    var textfieldHeight:NSLayoutConstraint?
    var textfieldHeightWithKeyBoard:CGFloat?
    var textfieldHeightWithoutKeyBoard:CGFloat = (UIScreen.main.bounds.height - 150)
    
    let textView: UITextView = {
        let textview = UITextView()
        textview.isEditable = true
        textview.font = UIFont.systemFont(ofSize: 20)
        textview.backgroundColor = .systemGray6
        return textview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleNewNote))
        
        view.addSubview(textView)
        textfieldHeight = NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: textfieldHeightWithoutKeyBoard)

        textView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        leading: view.safeAreaLayoutGuide.leadingAnchor,
                        bottom: nil,
                        trailing: view.safeAreaLayoutGuide.trailingAnchor,
                        padding: UIEdgeInsets(top: 16,
                                              left: 16,
                                              bottom: 0 ,
                                              right: -16))
        NSLayoutConstraint.activate([
            textfieldHeight!
        ])
        
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
        let textfieldHeightWithKeyBoard = ((textfieldHeightWithoutKeyBoard) - keybardFrame.height)

        UIView.animate(withDuration: 0,delay: 0,options: UIView.AnimationOptions.curveEaseIn,
                       animations: {
                        self.textfieldHeight?.constant = textfieldHeightWithKeyBoard
                        self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
       UIView.animate(withDuration: 0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
        self.textfieldHeight?.constant = self.textfieldHeightWithoutKeyBoard
        self.view.layoutIfNeeded()
       }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension AddNewNoteController: UITextViewDelegate {
}
