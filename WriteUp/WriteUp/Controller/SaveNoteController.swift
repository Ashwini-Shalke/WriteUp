//
//  AddNoteController.swift
//  WriteUp
//
//  Created by Ashwini shalke on 16/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
class SaveNoteController: UIViewController {
    let titleLabel = PrimaryLabel(labelName: Constant.AddNote.titleLabel)
    let titleTextField = PrimaryTextField(placeholderString: Constant.AddNote.titleTextFieldPlaceHolder)
    let summaryLabel = PrimaryLabel(labelName: Constant.AddNote.summaryLabel)
    let summaryTextField = PrimaryTextField(placeholderString: Constant.AddNote.summaryTextFieldPlaceHolder)
    let chooseTagLabel = PrimaryLabel(labelName: Constant.AddNote.chooseTagLabel)
    let titleView: UIView = UIView()
    let summaryView: UIView = UIView()
    let chooseTagView: UIView = UIView()
    var sampleString: String = ""
    
    let colorPickerView: ColorPickerView = {
        let pickerView = ColorPickerView()
        return pickerView
    }()
    

    
    func contructView(){
        titleView.addSubview(titleLabel)
        titleLabel.anchor(top: titleView.topAnchor, leading: titleView.leadingAnchor, bottom: nil, trailing: titleView.trailingAnchor, size: Constant.ProfileSC.Labelheight)
        
        titleView.addSubview(titleTextField)
        titleTextField.delegate = self
        titleTextField.isUserInteractionEnabled = true
        titleTextField.anchor(top: titleLabel.bottomAnchor, leading: titleView.leadingAnchor, bottom: nil, trailing: titleView.trailingAnchor,size: Constant.ProfileSC.TextFieldheight)
        
        summaryView.addSubview(summaryLabel)
        summaryLabel.anchor(top: summaryView.topAnchor,leading: summaryView.leadingAnchor, bottom: nil, trailing: summaryView.trailingAnchor,size: Constant.ProfileSC.Labelheight)
        
        summaryView.addSubview(summaryTextField)
        summaryTextField.delegate = self
        summaryTextField.isUserInteractionEnabled = true
        summaryTextField.anchor(top: summaryLabel.bottomAnchor, leading: summaryView.leadingAnchor, bottom: nil, trailing: summaryView.trailingAnchor,size: Constant.ProfileSC.TextFieldheight)
        
        
        chooseTagView.addSubview(chooseTagLabel)
        chooseTagLabel.anchor(top: chooseTagView.topAnchor, leading: chooseTagView.leadingAnchor, bottom: nil, trailing: chooseTagView.trailingAnchor, size: Constant.ProfileSC.Labelheight)
        
        chooseTagView.addSubview(colorPickerView)
        colorPickerView.anchor(top: chooseTagLabel.bottomAnchor, leading: chooseTagView.leadingAnchor, bottom: nil, trailing: chooseTagView.trailingAnchor,size: Constant.ProfileSC.TextFieldheight)
        
        
//        titleTextField.text = sampleString.lines[0]
//        summaryTextField.text = sampleString.lines[1]
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.title = Constant.AddNote.barLabel
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSaveNote))
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.contructView()
        
        let stackView = UIStackView(arrangedSubviews: [titleView,summaryView,chooseTagView])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        view.addSubview(stackView)
        // stack View :- need to calculate the number of items in stack view
        let stackHeight = CGSize(width: 0, height: (32 * 3) + (37 * 3) + 3)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0),size: stackHeight)
        hideKeyboard()
//        handleTitle()
    }
    
    @objc func handleSaveNote() {
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
    
//    func handleTitle(){
//        if let index = sampleString.firstIndex(of: "." || "\n") {
//            titleTextField.text = sampleString.prefix(upTo: index)
//        }
//    }
}


