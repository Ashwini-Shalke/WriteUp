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
        
//        let title = saveNoteView.titleTextField.text
//        let summary = saveNoteView.summaryTextField.text
//        let tag = "red"
        let authorId = 2
        
        let urlString = "https://bestnoteapp.herokuapp.com/notes"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer gqIMHata6XHdx4kjNOd/eg==", forHTTPHeaderField: "Authorization")
        
        let parameters = ["title": "Jiva",
                           "createdAt": "on 21 Oct",
                           "summery": "just now",
                           "tag": "Red",
                           "body": "it awesome and short"]
        
        guard let uploadData = try? JSONEncoder().encode(parameters) else {return}
        
        URLSession.shared.uploadTask(with: request, from: uploadData){ (data, response, err ) in
            if let err = err {
                print("Error", err)
            }
           
            let Notes = try! JSONDecoder().decode(SomeData.self, from: data!)
            print("Api response", Notes)
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                print("Server Error")
                return
            }
            if let mimeType = response.mimeType,
               mimeType == "application/json",
               let data = data,
               let dataString = String(data: data, encoding: .utf8){
                print(dataString)
            }
        }.resume()
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


