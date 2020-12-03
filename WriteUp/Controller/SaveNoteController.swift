//
//  AddNoteController.swift
//  WriteUp
//
//  Created by Ashwini shalke on 16/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
class SaveNoteController: UIViewController {
    let saveNoteView = SaveNoteView()
    var sampleString: String = ""
    let i = 0
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSaveNote))
        self.navigationItem.setHidesBackButton(false, animated: false)
        handleComponents()
        constructView()
        hideKeyboard()
        handleTitle()
    }
    
    func handleComponents(){
        saveNoteView.titleTextField.isUserInteractionEnabled = true
        saveNoteView.summaryTextField.isUserInteractionEnabled = true
        
        saveNoteView.titleTextField.delegate = self
        saveNoteView.summaryTextField.delegate = self
    }
    
    func constructView(){
        view.addSubview(saveNoteView)
        saveNoteView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
    }
    
    @objc func handleSaveNote() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        guard let controllersInStack = navigationController?.viewControllers else { return }
        if let _ = controllersInStack.first(where: { $0 is RootViewController }) {
            navigationController?.popToRootViewController(animated: true)
        }
    }
}

extension SaveNoteController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func hideKeyboard(){
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 50
    }
    
    func handleTitle(){
        saveNoteView.titleTextField.text = sampleString.title
        saveNoteView.summaryTextField.text = sampleString.description
    }
}


