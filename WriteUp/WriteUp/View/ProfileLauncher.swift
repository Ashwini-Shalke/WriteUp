//
//  ProfileLauncher.swift
//  WriteUp
//
//  Created by Ashwini shalke on 21/04/20.
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
 
class ProfileLauncher: UIViewController {
    let topViewContainer : UIView = {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = UIColor.systemPink
        return topView
    }()
    
    let placeHolderImageView : UIImageView = {
        let image = UIImage(named: "placeholder_photo")
        let placeholder = UIImageView()
        placeholder.image = image
        placeholder.contentMode = .scaleAspectFit
        placeholder.clipsToBounds = true
        placeholder.frame = CGRect(x: 0, y: 0, width: 160, height: 0)
        placeholder.round()
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        return placeholder
    }()
    
    let addImageButton: UIButton = {
        let image = UIImage(named: "camera_button")
        let addButton = UIButton()
        addButton.setImage(image, for: .normal)
        addButton.clipsToBounds = true
        addButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        return addButton
    }()
    
    @objc func pickImage() {
       
    }

    var nameView: UIView = UIView()
    var emailView: UIView = UIView()
    let phoneView: UIView = UIView()
    let noteView: UIView = UIView()
    
    
    func constractNameView() {
        let nameLabel = PrimaryLabel(labelName: "Name")
        nameView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: Constant.ProfileSC.Labelheight),
            nameLabel.trailingAnchor.constraint(equalTo: nameView.trailingAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: nameView.topAnchor)
        ])
        
        let nameTextField = PrimaryTextField(placeholderString: "Name")
        nameView.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: Constant.ProfileSC.TextFieldheight),
            nameTextField.trailingAnchor.constraint(equalTo: nameView.trailingAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: nameView.leadingAnchor),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor)
        ])
        
        let emailLabel = PrimaryLabel(labelName: "Email-ID")
        emailView.addSubview(emailLabel)
        NSLayoutConstraint.activate([
            emailLabel.heightAnchor.constraint(equalToConstant: Constant.ProfileSC.Labelheight),
            emailLabel.trailingAnchor.constraint(equalTo: emailView.trailingAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: emailView.leadingAnchor),
            emailLabel.topAnchor.constraint(equalTo: emailView.topAnchor)
        ])
        
        let emailTextField = PrimaryTextField(placeholderString: "Email-ID")
        emailView.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalToConstant: Constant.ProfileSC.TextFieldheight),
            emailTextField.trailingAnchor.constraint(equalTo: emailView.trailingAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: emailView.leadingAnchor),
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor)
        ])
        
        let phoneLabel = PrimaryLabel(labelName: "Phone number")
        phoneView.addSubview(phoneLabel)
        NSLayoutConstraint.activate([
            phoneLabel.heightAnchor.constraint(equalToConstant: Constant.ProfileSC.Labelheight),
            phoneLabel.trailingAnchor.constraint(equalTo: phoneView.trailingAnchor),
            phoneLabel.leadingAnchor.constraint(equalTo: phoneView.leadingAnchor),
            phoneLabel.topAnchor.constraint(equalTo: phoneView.topAnchor)
        ])
        
        let phoneTextField = PrimaryTextField(placeholderString: "Phone number")
        phoneView.addSubview(phoneTextField)
        NSLayoutConstraint.activate([
            phoneTextField.heightAnchor.constraint(equalToConstant: Constant.ProfileSC.TextFieldheight),
            phoneTextField.trailingAnchor.constraint(equalTo: phoneView.trailingAnchor),
            phoneTextField.leadingAnchor.constraint(equalTo: phoneView.leadingAnchor),
            phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor)
        ])
        
        let noteLabel = PrimaryLabel(labelName: "Total Notes")
        noteView.addSubview(noteLabel)
        NSLayoutConstraint.activate([
            noteLabel.heightAnchor.constraint(equalToConstant: Constant.ProfileSC.Labelheight),
            noteLabel.trailingAnchor.constraint(equalTo: noteView.trailingAnchor),
            noteLabel.leadingAnchor.constraint(equalTo: noteView.leadingAnchor),
            noteLabel.topAnchor.constraint(equalTo: noteView.topAnchor)
        ])
        
        let noteTextField = PrimaryTextField(placeholderString: "0")
        noteView.addSubview(noteTextField)
        NSLayoutConstraint.activate([
            noteTextField.heightAnchor.constraint(equalToConstant: Constant.ProfileSC.TextFieldheight),
            noteTextField.trailingAnchor.constraint(equalTo: noteView.trailingAnchor),
            noteTextField.leadingAnchor.constraint(equalTo: noteView.leadingAnchor),
            noteTextField.topAnchor.constraint(equalTo: noteLabel.bottomAnchor)
        ])
        
    }
    
    func setupProfileDetails(){
        self.constractNameView()
        let stackView = UIStackView(arrangedSubviews: [nameView,emailView,phoneView,noteView])
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .orange
        
        view.addSubview(stackView)
        // stack View :- need to calculate the number of items in stack view 
        let stackHeight = CGFloat((32 * 4) + (37 * 4))
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: stackHeight),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topViewContainer.bottomAnchor)
        ])
    }
    
    func autolayout() {
        view.addSubview(topViewContainer)
        NSLayoutConstraint.activate([
            topViewContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            topViewContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
            topViewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topViewContainer.heightAnchor.constraint(equalToConstant: 200)
        ])
    
        topViewContainer.addSubview(placeHolderImageView)
        NSLayoutConstraint.activate([
            placeHolderImageView.topAnchor.constraint(equalTo: topViewContainer.topAnchor, constant: 19),
            placeHolderImageView.centerXAnchor.constraint(equalTo: topViewContainer.centerXAnchor),
            placeHolderImageView.bottomAnchor.constraint(equalTo: topViewContainer.bottomAnchor, constant: -18),
            placeHolderImageView.widthAnchor.constraint(equalToConstant: 160)
        ])
    
        topViewContainer.addSubview(addImageButton)
        NSLayoutConstraint.activate([
            addImageButton.topAnchor.constraint(equalTo: placeHolderImageView.topAnchor, constant: 109),
            addImageButton.leftAnchor.constraint(equalTo: placeHolderImageView.leftAnchor, constant: 111),
            addImageButton.widthAnchor.constraint(equalToConstant: 41),
            addImageButton.heightAnchor.constraint(equalToConstant: 41)])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.topItem?.title = "Profile"
       navigationController?.navigationBar.tintColor = UIColor.systemPink
        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEdit))
        autolayout()
        setupProfileDetails()
    }
    
    @objc func handleEdit(){
        
    }
    
}
