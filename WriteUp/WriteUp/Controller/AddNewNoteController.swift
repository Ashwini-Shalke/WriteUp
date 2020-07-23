//
//  AddNewNote.swift
//  WriteUp
//
//  Created by Ashwini shalke on 20/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class AddNewNoteController: UIViewController, UITextViewDelegate, bottomToolBarDelegate {
    var textfieldHeightConstraint:NSLayoutConstraint?
    var textfieldHeightwithKeyboard = (UIScreen.main.bounds.height)
    var texfieldHeightwithoutKeyboard = (UIScreen.main.bounds.height - 50)
    var verticalSafeAreaInset = CGFloat()
    let nextButton = OnboardingButton(titletext: Constant.AddNote.nextButtonTitle)

    lazy var inputAccesssoryToolView: BottomToolBar = {
        var  toolView = BottomToolBar()
        toolView.toolbarDelegate = self
        toolView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        return toolView
    }()
    
    lazy var bottomToolBar : BottomToolBar = {
        var bottomBar = BottomToolBar()
        bottomBar.toolbarDelegate = self
        return bottomBar
    }()
    
    let textView: UITextView = {
        let textview = UITextView()
        textview.allowsEditingTextAttributes = true
        textview.font = UIFont().textInput()
        textview.keyboardDismissMode = .interactive
        textview.backgroundColor = .green
        return textview
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "10 June 2020 at 11:21 AM"
        label.font = UIFont().formControlSegmented()
        label.textColor = UIColor.systemPink
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: 154, height: 0)
        return label
    }()
    
    override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *){
            verticalSafeAreaInset = self.view.safeAreaInsets.top + self.view.safeAreaInsets.bottom
        } else {
            verticalSafeAreaInset = self.view.safeAreaInsets.top
        }
        view.addSubview(textView)
        textView.anchor(top: view.safeAreaLayoutGuide.topAnchor,leading: view.safeAreaLayoutGuide.leadingAnchor,bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,padding: UIEdgeInsets(top: 0,left: 16,bottom: 0,right: -16))
         textfieldHeightConstraint = NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: texfieldHeightwithoutKeyboard - verticalSafeAreaInset)
        NSLayoutConstraint.activate([ textfieldHeightConstraint! ])
        view.layer.layoutIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: nextButton)
        navigationItem.titleView = dateLabel
        navigationItem.largeTitleDisplayMode = .never
        
        self.navigationItem.setHidesBackButton(false, animated: false)
        nextButton.setTitleColor(.systemPink, for: .normal)
        nextButton.addTarget(self, action: #selector(handleNewNote), for: .touchUpInside)
        textView.delegate = self
        
        view.addSubview(bottomToolBar)
        bottomToolBar.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 50, left: 0, bottom: -1, right: 0))
        bottomToolBar.hideBackground()
    }

    func trashButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func clearButton() {
        if textView.text != "" {
            textView.text = ""
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        textView.resignFirstResponder()
    }
    
    @objc func handleNewNote(){
        self.view.endEditing(true)
        let saveNote = SaveNoteController()
        saveNote.sampleString = textView.text
        navigationController?.pushViewController(saveNote, animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
                
        let textfieldHeightwithKeyboard = (self.textfieldHeightwithKeyboard - verticalSafeAreaInset) -  keyboardFrame!.height
        
        UIView.animate(withDuration: keyboardDuration!) {
            self.textfieldHeightConstraint?.constant = textfieldHeightwithKeyboard
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        self.textfieldHeightConstraint?.constant = self.texfieldHeightwithoutKeyboard - self.verticalSafeAreaInset
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        UIView.animate(withDuration: keyboardDuration!) {
            self.view.layoutIfNeeded()
        }
    }
    
   override func viewWillAppear(_ animated: Bool) {
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension AddNewNoteController {
    override var inputAccessoryView: UIView? {
        get {
            inputAccesssoryToolView.hideBackground()
            return self.inputAccesssoryToolView
        }
    }
    
    override func resignFirstResponder() -> Bool {
        return true
    }
}
