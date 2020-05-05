//
//  ProfileLauncher.swift
//  WriteUp
//
//  Created by Ashwini shalke on 21/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

protocol ProfileLauncherDelegate {
    func dismissHome()
}

class ProfileLauncher: UIViewController {
    var profiledelegate: ProfileLauncherDelegate?
    let signoutButton = PrimaryButton(titletext: Constant.ProfileSC.signoutButtonTitle)
    let stackHeight = CGSize(width: 0, height: (32 * 4) + (37 * 4) + 4)
    
    let topViewContainer : UIView = {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = UIColor.systemPink
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
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(imagePicker), for: .touchUpInside)
        return button
    }()
    

    func autolayout() {
        view.addSubview(topViewContainer)
        topViewContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor , leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,size: CGSize(width: 0, height: 200))
        
        topViewContainer.addSubview(placeHolderButton)
        placeHolderButton.centerXAnchor.constraint(equalTo: topViewContainer.centerXAnchor).isActive = true
        placeHolderButton.centerYAnchor.constraint(equalTo: topViewContainer.centerYAnchor).isActive = true
        
        view.addSubview(signoutButton)
        signoutButton.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 27, bottom: 0, right: -27), size: CGSize(width: 0, height: 44))
        signoutButton.addTarget(self, action: #selector(handleSignout), for: .touchUpInside)
        
        let profileDetail = ProfileDetail()
        view.addSubview(profileDetail)
        profileDetail.anchor(top: topViewContainer.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, size :stackHeight)
    }
        
        @objc func handleSignout(){
            self.navigationController?.popViewController(animated: false)
            profiledelegate?.dismissHome()
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = UIColor.white
            navigationController?.navigationBar.topItem?.title = Constant.ProfileSC.navTitle
            navigationController?.navigationBar.tintColor = UIColor.systemPink
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEdit))
            autolayout()
        }
        
        @objc func handleEdit(){
        }
    
}

extension ProfileLauncher: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func imagePicker() {
    let imagePickerController = UIImagePickerController()
           imagePickerController.delegate = self
           let actionsheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
           actionsheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
               if UIImagePickerController.isSourceTypeAvailable(.camera){
                   imagePickerController.sourceType = .camera
                   self.present(imagePickerController,animated: true, completion: nil)
               }
               print("Camera not available")
           }))
           
           actionsheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
               imagePickerController.sourceType = .photoLibrary
               self.present(imagePickerController,animated: true, completion: nil)
           }))
           
           actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
           self.present(actionsheet,animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //to get the real information of image which the user has picked
        let imageData = info[.originalImage] as! UIImage
        print(imageData)
        let image_Data:Data = imageData.pngData()!
        let imgstr = image_Data.base64EncodedData()
        print(imgstr)
      
        placeHolderButton.setImage(imageData, for: .normal)
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
