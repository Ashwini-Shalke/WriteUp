//
//  EditProfileLauncher.swift
//  WriteUp
//
//  Created by Ashwini shalke on 07/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

protocol EditProfileDelegate: AnyObject {
    func handleEdit()
}

class EditProfileLauncher: UIViewController,UITextFieldDelegate {
    weak var editProfileDelegate: EditProfileDelegate?
    let profileDetail = ProfileDetail()
    var activeTextField = UITextField()
    var parentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.systemPink

        view.addSubview(profileDetail)
        profileDetail.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        handleComponenets()
        hideKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keybardFrame = keyboardSize.cgRectValue
        let keyboardYaxis = self.view.frame.size.height - keybardFrame.height
        let editTextFieldY: CGFloat = parentView.frame.origin.y
        
        if self.view.frame.origin.y >= 0 {
            if editTextFieldY > keyboardYaxis - 60 {
                UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editTextFieldY - (keyboardYaxis - 80)), width: self.view.bounds.width, height: self.view.bounds.height)
                }, completion: nil)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        activeTextField.autocorrectionType = .no
        guard let superView = activeTextField.superview else {return}
        parentView = superView
    }
    
    @objc func handleDone(){
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func handleComponenets(){
        profileDetail.emailTextField.isUserInteractionEnabled = true
        profileDetail.nameTextField.isUserInteractionEnabled = true
        profileDetail.phoneTextField.isUserInteractionEnabled = true
        profileDetail.placeHolderButton.isUserInteractionEnabled = true
        profileDetail.emailTextField.delegate = self
        profileDetail.phoneTextField.delegate = self
        profileDetail.nameTextField.delegate = self
        profileDetail.placeHolderButton.addTarget(self, action: #selector(imagePicker), for: .touchUpInside)
    }
    
    func hideKeyboard(){
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
}

extension EditProfileLauncher: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePicker() {
     UIImagePickerController().pickImage(view: self)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //to get the real information of image which the user has picked
        let imageData = info[.originalImage] as! UIImage
//        let image_Data:Data = imageData.pngData()!
//        let imgstr = image_Data.base64EncodedData()
        profileDetail.placeHolderButton.setImage(imageData, for: .normal)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
