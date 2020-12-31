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
    var noteDescription: String = ""
    let i = 0
    let createDate:String = ""
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSaveNote))
        self.navigationItem.setHidesBackButton(false, animated: false)
        handleComponents()
        constructView()
        hideKeyboard()
        setTitleAndSummary()
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
        let parameters = NoteData(title: saveNoteView.titleTextField.text, createdAt: createDate.currentDate , summery: saveNoteView.summaryTextField.text, authorID: 2, tag: "lo", body: noteDescription)
        
        NoteAPIService.sharedInstance.createNote(httpMethod: "POST", data: parameters)
        navigationController?.popViewController(animated: true)
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
    
    func setTitleAndSummary(){
        saveNoteView.titleTextField.text = noteDescription.title
        saveNoteView.summaryTextField.text = noteDescription.description
    }
}


