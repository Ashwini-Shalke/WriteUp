//
//  ProfileViewCell.swift
//  WriteUp
//
//  Created by Ashwini shalke on 16/03/21.
//  Copyright © 2021 Ashwini Shalke. All rights reserved.
//

import UIKit

protocol profileCellDelegate : class {
    func newData(user: [Int: String])
    func handleActiveTextField(_ textField: UITextField)
    func handleReturnTextField(_ textField: UITextField)
}

class ProfileCell: UITableViewCell, UITextFieldDelegate {
    var UserDetail = [Int: String]()
    weak var cellDelegate : profileCellDelegate?
    
    enum TextFieldData: Int {
        case usernameTextField = 0
        case emailTextField
        case mobileTextField
        case notesTextField
    }
    
    var state: Bool = false
    
    var user: [Int: String]?{
        didSet {
            guard let getUser = user  else { return }
            print("getUser", getUser)
            cellDelegate?.newData(user: getUser)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var getTextValue : String? {
        didSet {
            guard let textValue = getTextValue else {return}
            textName.text = textValue
        }
    }
    
    var labelName: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .systemGray4
        nameLabel.font = UIFont.systemFont(ofSize: 15,weight: .semibold)
        nameLabel.textAlignment = .left
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    var textName: UITextField = {
        let nameText = UITextField()
        nameText.textColor = .black
        nameText.font = UIFont.systemFont(ofSize: 18,weight: .semibold)
        nameText.textAlignment = .left
        nameText.isUserInteractionEnabled = false
        nameText.translatesAutoresizingMaskIntoConstraints = false
        return nameText
    }()
    
    func setupLayout(){
        self.addSubview(labelName)
        NSLayoutConstraint.activate([
                                        labelName.heightAnchor.constraint(equalToConstant: 20),
                                        labelName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                                        labelName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                                        labelName.topAnchor.constraint(equalTo: self.topAnchor, constant: 12)])
        self.addSubview(textName)
        NSLayoutConstraint.activate([
                                        textName.heightAnchor.constraint(equalToConstant: 30),
                                        textName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                                        textName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                                        textName.topAnchor.constraint(equalTo: self.labelName.bottomAnchor, constant: -2)])
        textName.delegate = self
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        cellDelegate?.handleActiveTextField(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cellDelegate?.handleReturnTextField(textField)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if state {
            textName.becomeFirstResponder()
            textName.isUserInteractionEnabled = true
            textName.clearButtonMode = .whileEditing
        }
        else {
            textName.isUserInteractionEnabled = false
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case TextFieldData.usernameTextField.rawValue:
            user = [textField.tag: textField.text!]
            
        case TextFieldData.emailTextField.rawValue:
            user = [textField.tag: textField.text!]
            
        case TextFieldData.mobileTextField.rawValue:
            user = [textField.tag: textField.text!]
            
        case TextFieldData.notesTextField.rawValue:
            user = [textField.tag: textField.text!]
            
        default:
            break
        }
    }
}
