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
    var activeTextFieldBounds = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        handleComponents()
        hideKeyboard()
        setupNotifications()
    }
    
    func setupViews(){
        view.backgroundColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        navigationItem.rightBarButtonItem?.tintColor = Constant.SecondaryColor
        
        view.addSubview(profileDetail)
        profileDetail.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    func setupNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        let keyboardYaxis = self.view.frame.size.height - keyboardFrame.height
        
        let editTextFieldY: CGFloat = activeTextFieldBounds.minY
        if self.view.frame.origin.y >= 0 {
            if editTextFieldY > keyboardYaxis - 100 {
                UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editTextFieldY - (keyboardYaxis - 100)), width: self.view.bounds.width, height: self.view.bounds.height)
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
        let activeTextField = textField
        activeTextFieldBounds = activeTextField.convert(activeTextField.bounds, to: self.view)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 50
    }
    
    @objc func handleDone(){
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func handleComponents(){
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
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

extension EditProfileLauncher: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePicker() {
        UIImagePickerController().pickImage(view: self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //to get the real information of image which the user has picked
        let imageData = info[.originalImage] as! UIImage
        //TODO: Remove this
        //        let image_Data:Data = imageData.pngData()!
        //        let imgstr = image_Data.base64EncodedData()
        profileDetail.placeHolderButton.setImage(imageData, for: .normal)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
