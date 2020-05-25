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

class ProfileDetail: BaseView,EditProfileDelegate{
    func handleEdit() {

    }

    lazy var editProfile : EditProfileLauncher = {
        var eP = EditProfileLauncher()
        eP.editProfileDelegate = self
        return eP
    }()
    
    let nameView: UIView = UIView()
    let emailView: UIView = UIView()
    let phoneView: UIView = UIView()
    let noteView: UIView = UIView()
    
    let nameTextField = PrimaryTextField(placeholderString: Constant.ProfileSC.nameLabel)
    let emailTextField = PrimaryTextField(placeholderString: Constant.ProfileSC.emailLabel)
    let phoneTextField = PrimaryTextField(placeholderString: Constant.ProfileSC.phoneLabel)
    let noteTextField = PrimaryTextField(placeholderString: Constant.ProfileSC.noOfNotes)
    
    let topViewContainer : UIView = {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = UIColor.systemYellow
        return topView
    }()
    
    let placeHolderButton: UIButton = {
        let button = UIButton()
        let bImage = UIImage(named: Constant.ProfileSC.placeholderImageName)
        button.setImage(bImage, for: .normal)
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.frame = CGRect(x: 0, y: 0, width: 120, height: 120 )
        button.layer.cornerRadius = button.bounds.size.width * 0.5
        button.isUserInteractionEnabled = false
        return button
    }()
    
    
    override func setup() {
        super.setup()
        backgroundColor = UIColor.white
        setupProfileDetails()
    }
    
    func constructBottomView() {
        let nameLabel = PrimaryLabel(labelName: Constant.ProfileSC.nameLabel)
        nameView.addSubview(nameLabel)
        nameLabel.anchor(top: nameView.topAnchor, leading: nameView.leadingAnchor, bottom: nil, trailing: nameView.trailingAnchor, size: Constant.ProfileSC.Labelheight)
        
        nameView.addSubview(nameTextField)
        nameTextField.anchor(top: nameLabel.bottomAnchor, leading: nameView.leadingAnchor, bottom: nil, trailing: nameView.trailingAnchor,size: Constant.ProfileSC.TextFieldheight)
        
        let emailLabel = PrimaryLabel(labelName: Constant.ProfileSC.emailLabel)
        emailView.addSubview(emailLabel)
        emailLabel.anchor(top: emailView.topAnchor,leading: emailView.leadingAnchor, bottom: nil, trailing: emailView.trailingAnchor,size: Constant.ProfileSC.Labelheight)
        
       
        emailView.addSubview(emailTextField)
        emailTextField.anchor(top: emailLabel.bottomAnchor, leading: emailView.leadingAnchor, bottom: nil, trailing: emailView.trailingAnchor,size: Constant.ProfileSC.TextFieldheight)
        
        let phoneLabel = PrimaryLabel(labelName: Constant.ProfileSC.phoneLabel)
        phoneView.addSubview(phoneLabel)
        phoneLabel.anchor(top: phoneView.topAnchor, leading: phoneView.leadingAnchor, bottom: nil, trailing: phoneView.trailingAnchor, size: Constant.ProfileSC.Labelheight)
        
        phoneView.addSubview(phoneTextField)
        phoneTextField.anchor(top: phoneLabel.bottomAnchor, leading: phoneView.leadingAnchor, bottom: nil,trailing: phoneView.trailingAnchor, size: Constant.ProfileSC.TextFieldheight)
        
        let noteLabel = PrimaryLabel(labelName: Constant.ProfileSC.noteLabel)
        noteView.addSubview(noteLabel)
        noteLabel.anchor(top: noteView.topAnchor,leading: noteView.leadingAnchor, bottom: nil, trailing: noteView.trailingAnchor,size: Constant.ProfileSC.Labelheight)
        
        noteView.addSubview(noteTextField)
        noteTextField.anchor(top: noteLabel.bottomAnchor, leading: noteView.leadingAnchor, bottom: nil, trailing: noteView.trailingAnchor, size: Constant.ProfileSC.TextFieldheight)
    }
    
    func setupProfileDetails(){
        addSubview(topViewContainer)
        topViewContainer.anchor(top: safeAreaLayoutGuide.topAnchor , leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor,size: CGSize(width: 0, height: 200))
        
        topViewContainer.addSubview(placeHolderButton)
        placeHolderButton.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: CGSize(width: 120, height: 120))
        placeHolderButton.centerXAnchor.constraint(equalTo: topViewContainer.centerXAnchor).isActive = true
        placeHolderButton.centerYAnchor.constraint(equalTo: topViewContainer.centerYAnchor).isActive = true
        
        self.constructBottomView()
        let stackView = UIStackView(arrangedSubviews: [nameView,emailView,phoneView,noteView])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        addSubview(stackView)
        // stack View :- need to calculate the number of items in stack view
        let stackHeight = CGSize(width: 0, height: (32 * 4) + (37 * 4) + 4)
        stackView.anchor(top: topViewContainer.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, size: stackHeight)
    }

}



