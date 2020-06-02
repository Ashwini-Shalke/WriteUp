//
//  AddNewNote.swift
//  WriteUp
//
//  Created by Ashwini shalke on 20/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class AddNewNoteController: UIViewController, UITextViewDelegate{
    var textfieldHeight:NSLayoutConstraint?
    var textfieldHeightWithKeyBoard:CGFloat = (UIScreen.main.bounds.height - 200)
    var textfieldHeightWithoutKeyBoard:CGFloat = (UIScreen.main.bounds.height - 150)
    var alphaView = UIView()
    
    let nextButton = OnboardingButton(titletext: Constant.AddNote.nextButtonTitle)
    
    let plusNoteButton: UIButton = {
        let addImage = UIImage(named: "add")
        let button = UIButton()
        button.setImage(addImage, for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(handlePlusNote), for: .touchUpInside)
        return button
    }()
    
    let deleteNoteButton: UIButton = {
        let trashImage = UIImage(named: "trash")
        let button = UIButton()
        button.setImage(trashImage, for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    
    let textView: UITextView = {
        let textview = UITextView()
        textview.isEditable = true
        textview.allowsEditingTextAttributes = true
        textview.keyboardDismissMode = .interactive
  
        textview.font = UIFont.systemFont(ofSize: 20)
        textview.backgroundColor = .systemGray6
        return textview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: nextButton)
        self.navigationItem.setHidesBackButton(true, animated: false)
        nextButton.setTitleColor(.systemPink, for: .normal)
        nextButton.addTarget(self, action: #selector(handleNewNote), for: .touchUpInside)
        
        textView.delegate = self
        view.addSubview(textView)
        textfieldHeight = NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: UIScreen.main.bounds.height - 150)
        
        textView.anchor(top: view.safeAreaLayoutGuide.topAnchor,leading: view.safeAreaLayoutGuide.leadingAnchor,bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,padding: UIEdgeInsets(top: 16,left: 16,bottom: 0,right: -16))
        
        NSLayoutConstraint.activate([
            textfieldHeight!
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let stackView = UIStackView(arrangedSubviews: [deleteNoteButton,plusNoteButton])
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: 50))
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
        textView.resignFirstResponder()
        textView.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        textView.resignFirstResponder()
    }
        
    @objc func handlePlusNote(){
        if textView.text != "" {
            textView.text = ""
        }
    }
    
    @objc func handleNewNote(){
        self.view.endEditing(true)
        let addNote = AddNoteController()
        navigationController?.pushViewController(addNote, animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keybardFrame = keyboardSize.cgRectValue
        let textfieldHeight = ((UIScreen.main.bounds.height - 150) - keybardFrame.height)
        
        UIView.animate(withDuration: 0,delay: 0,options: UIView.AnimationOptions.curveEaseIn,
                       animations: {
                        self.textfieldHeight?.constant = textfieldHeight
                        self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        UIView.animate(withDuration: 0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.textfieldHeight?.constant = UIScreen.main.bounds.height - 150
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
