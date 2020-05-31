//
//  AddNoteController.swift
//  WriteUp
//
//  Created by Ashwini shalke on 16/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class AddNoteController: UIViewController {
    let nextButton = OnboardingButton(titletext: "Next")
    let titleLabel = PrimaryLabel(labelName: "Title")
    let titleTextField = PrimaryTextField(placeholderString: "Keep it short")
    let summaryLabel = PrimaryLabel(labelName: "Summary")
    let summaryTextField = PrimaryTextField(placeholderString: "Add small description")
    let chooseTagLabel = PrimaryLabel(labelName: "Choose tag")
    let titleView: UIView = UIView()
    let summaryView: UIView = UIView()
    let chooseTagView: UIView = UIView()
    
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
        
        
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.title = "Add Note"
        nextButton.setTitleColor(.systemPink, for: .normal)
        nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: nextButton)
        self.contructView()
        
        let stackView = UIStackView(arrangedSubviews: [titleView,summaryView,chooseTagView])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        view.addSubview(stackView)
        // stack View :- need to calculate the number of items in stack view
        let stackHeight = CGSize(width: 0, height: (32 * 3) + (37 * 3) + 3)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: stackHeight)
        hideKeyboard()
    }
    
    @objc func handleNext(){
        let newNote = AddNewNoteController()
        navigationController?.pushViewController(newNote, animated: true)
    }
    
    
}


extension AddNoteController: UITextFieldDelegate {
    
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
    
}


