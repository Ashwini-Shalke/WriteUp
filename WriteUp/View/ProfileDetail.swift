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
        fatalError(Constant.initFatalError)
    }
}

class ProfileDetail: BaseView,EditProfileDelegate {
    let nameLabel = PrimaryLabel(labelName: Constant.ProfileSC.nameLabel)
    let emailLabel = PrimaryLabel(labelName: Constant.ProfileSC.emailLabel)
    let phoneLabel = PrimaryLabel(labelName: Constant.ProfileSC.phoneLabel)
    let noteLabel = PrimaryLabel(labelName: Constant.ProfileSC.noteLabel)
    let switchLabel = PrimaryLabel(labelName: Constant.ProfileSC.switchLabel)
    
    let nameTextField = PrimaryTextField(placeholderString: Constant.ProfileSC.nameLabel)
    let emailTextField = PrimaryTextField(placeholderString: Constant.ProfileSC.emailLabel)
    let phoneTextField = PrimaryTextField(placeholderString: Constant.ProfileSC.phoneLabel)
    let noteTextField = PrimaryTextField(placeholderString: Constant.ProfileSC.noOfNotes)
    
    let containerStackView:UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    let scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let switchView: UIView = {
        let switchView = UIView()
        return switchView
    }()
    
    let screenLockSwitch = UISwitch()
    
    let switchStackView: UIStackView = {
        let switchStackView = UIStackView()
        switchStackView.backgroundColor = UIColor.green
        return switchStackView
    }()
    
    let topViewContainer : UIView = {
        let topView = UIView()
        return topView
    }()
    
    lazy var editProfile : EditProfileLauncher = {
        var eP = EditProfileLauncher()
        eP.editProfileDelegate = self
        return eP
    }()
    
    let placeHolderButton: UIButton = {
        let button = UIButton()
        let smallConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let smallSymbolImage = UIImage(systemName: "person.crop.circle", withConfiguration: smallConfiguration)
        button.setImage(smallSymbolImage, for: .normal)
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
        setupProfileDetailsView()
    }
    
    func setupProfileDetailsView(){
        addSubview(topViewContainer)
        topViewContainer.anchor(top: safeAreaLayoutGuide.topAnchor , leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor,size: CGSize(width: 0, height: 175))
        
        topViewContainer.addSubview(placeHolderButton)
        placeHolderButton.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: CGSize(width: 120, height: 120))
        placeHolderButton.centerXAnchor.constraint(equalTo: topViewContainer.centerXAnchor).isActive = true
        placeHolderButton.centerYAnchor.constraint(equalTo: topViewContainer.centerYAnchor).isActive = true
        
        //setup screenLockSwitch
        screenLockSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.95)
        switchView.addSubview(switchLabel)
        switchView.addSubview(screenLockSwitch)
        switchLabel.anchor(top: switchView.topAnchor, leading: switchView.leadingAnchor, bottom: switchView.bottomAnchor, trailing: nil, size: CGSize(width: 300, height: 0))
        screenLockSwitch.anchor(top: switchView.topAnchor , leading: switchLabel.trailingAnchor, bottom: nil, trailing: switchView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -10))
        
        addSubview(scrollView)
        scrollView.anchor(top: topViewContainer.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
        
        scrollView.addSubview(containerStackView)
        containerStackView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        
        //setup stackView
        let viewArray = [nameLabel,nameTextField, phoneLabel, phoneTextField, emailLabel, emailTextField, noteLabel, noteTextField, switchView]
        let stackView = UIStackView(arrangedSubviews: viewArray)
        containerStackView.addSubview(stackView)
        stackView.anchor(top: containerStackView.topAnchor, leading: containerStackView.leadingAnchor, bottom: containerStackView.bottomAnchor, trailing: containerStackView.trailingAnchor)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
    }
    
    func handleEdit() {
        //Todo: need to decide
    }
}



