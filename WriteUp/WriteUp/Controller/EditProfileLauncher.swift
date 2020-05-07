//
//  EditProfileLauncher.swift
//  WriteUp
//
//  Created by Ashwini shalke on 07/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

protocol EditProfileDelegate {
    func handleEdit()
}

class EditProfileLauncher: UIViewController,UITextFieldDelegate {
    
    var editProfileDelegate: EditProfileDelegate?
    let profileDetail = ProfileDetail()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))

        view.addSubview(profileDetail)
        profileDetail.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        handleTextField()
    }
    
    @objc func handleDone(){
        print("done")
    }
    
    func handleTextField(){
        profileDetail.emailTextField.isUserInteractionEnabled = true
        profileDetail.nameTextField.isUserInteractionEnabled = true
        profileDetail.phoneTextField.isUserInteractionEnabled = true
        profileDetail.emailTextField.delegate = self
        profileDetail.phoneTextField.delegate = self
        profileDetail.nameTextField.delegate = self
        
    }
    
}



//extension ProfileLauncher: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    @objc func imagePicker() {
//    let imagePickerController = UIImagePickerController()
//           imagePickerController.delegate = self
//           let actionsheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
//           actionsheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
//               if UIImagePickerController.isSourceTypeAvailable(.camera){
//                   imagePickerController.sourceType = .camera
//                   self.present(imagePickerController,animated: true, completion: nil)
//               }
//               print("Camera not available")
//           }))
//
//           actionsheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
//               imagePickerController.sourceType = .photoLibrary
//               self.present(imagePickerController,animated: true, completion: nil)
//           }))
//
//           actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//           self.present(actionsheet,animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        //to get the real information of image which the user has picked
//        let imageData = info[.originalImage] as! UIImage
//        print(imageData)
//        let image_Data:Data = imageData.pngData()!
//        let imgstr = image_Data.base64EncodedData()
//        print(imgstr)
//
//        placeHolderButton.setImage(imageData, for: .normal)
//        picker.dismiss(animated: true, completion: nil)
//    }
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//}
