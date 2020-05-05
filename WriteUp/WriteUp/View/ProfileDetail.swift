//
//  ProfileDetail.swift
//  WriteUp
//
//  Created by Ashwini shalke on 05/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    func setup(){}
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ProfileDetail: BaseView {
    var nameView: UIView = UIView()
    var emailView: UIView = UIView()
    let phoneView: UIView = UIView()
    let noteView: UIView = UIView()
    
    override func setup() {
        super.setup()
        backgroundColor = UIColor.white
        setupProfileDetails()
    }
    
    func constractNameView() {
        let nameLabel = PrimaryLabel(labelName: Constant.ProfileSC.nameLabel)
        nameView.addSubview(nameLabel)
        nameLabel.anchor(top: nameView.topAnchor, leading: nameView.leadingAnchor, bottom: nil, trailing: nameView.trailingAnchor, size: Constant.ProfileSC.Labelheight)
        
        let nameTextField = PrimaryTextField(placeholderString: Constant.ProfileSC.nameLabel)
        nameView.addSubview(nameTextField)
        nameTextField.anchor(top: nameLabel.bottomAnchor, leading: nameView.leadingAnchor, bottom: nil, trailing: nameView.trailingAnchor,size: Constant.ProfileSC.TextFieldheight)
        
        let emailLabel = PrimaryLabel(labelName: Constant.ProfileSC.emailLabel)
        emailView.addSubview(emailLabel)
        emailLabel.anchor(top: emailView.topAnchor,leading: emailView.leadingAnchor, bottom: nil, trailing: emailView.trailingAnchor,size: Constant.ProfileSC.Labelheight)
        
        let emailTextField = PrimaryTextField(placeholderString: Constant.ProfileSC.emailLabel)
        emailView.addSubview(emailTextField)
        emailTextField.anchor(top: emailLabel.bottomAnchor, leading: emailView.leadingAnchor, bottom: nil, trailing: emailView.trailingAnchor,size: Constant.ProfileSC.TextFieldheight)
        
        let phoneLabel = PrimaryLabel(labelName: Constant.ProfileSC.phoneLabel)
        phoneView.addSubview(phoneLabel)
        phoneLabel.anchor(top: phoneView.topAnchor, leading: phoneView.leadingAnchor, bottom: nil, trailing: phoneView.trailingAnchor, size: Constant.ProfileSC.Labelheight)
        
        let phoneTextField = PrimaryTextField(placeholderString: Constant.ProfileSC.phoneLabel)
        phoneView.addSubview(phoneTextField)
        phoneTextField.anchor(top: phoneLabel.bottomAnchor, leading: phoneView.leadingAnchor, bottom: nil,trailing: phoneView.trailingAnchor, size: Constant.ProfileSC.TextFieldheight)
        
        let noteLabel = PrimaryLabel(labelName: Constant.ProfileSC.noteLabel)
        noteView.addSubview(noteLabel)
        noteLabel.anchor(top: noteView.topAnchor,leading: noteView.leadingAnchor, bottom: nil, trailing: noteView.trailingAnchor,size: Constant.ProfileSC.Labelheight)
        
        let noteTextField = PrimaryTextField(placeholderString: Constant.ProfileSC.noOfNotes)
        noteView.addSubview(noteTextField)
        noteTextField.anchor(top: noteLabel.bottomAnchor, leading: noteView.leadingAnchor, bottom: nil, trailing: noteView.trailingAnchor, size: Constant.ProfileSC.TextFieldheight)
    }
    
    func setupProfileDetails(){
        self.constractNameView()
        let stackView = UIStackView(arrangedSubviews: [nameView,emailView,phoneView,noteView])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
      addSubview(stackView)
        // stack View :- need to calculate the number of items in stack view
        let stackHeight = CGSize(width: 0, height: (32 * 4) + (37 * 4) + 4)
        stackView.anchor(top: topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, size: stackHeight)
    }
}
