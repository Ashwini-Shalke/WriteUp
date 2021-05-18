//
//  Extension.swift
//  WriteUp
//
//  Created by Ashwini shalke on 15/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

extension UserDefaults {
    enum UserDefaultKey: String {
        case isSignedIn
        case isLockedOn
        case appleAuthorizedUserIDKey
    }
    
    func setIsSignedIn(value:Bool) {
//        set(value, forKey: UserDefaultKey.isSignedIn.rawValue)
        set(value, forKey: UserDefaultKey.appleAuthorizedUserIDKey.rawValue)
        
        synchronize()
    }
    
    func setIsScreenLockedOn(value:Bool){
        set(value, forKey: UserDefaultKey.isLockedOn.rawValue)
        synchronize()
    }
    
    func isSignedIn() -> Bool {
//        return bool(forKey: UserDefaultKey.isSignedIn.rawValue)
        return bool(forKey: UserDefaultKey.appleAuthorizedUserIDKey.rawValue)
    }
    
    func isScreenLockedOn()-> Bool {
        return bool(forKey: UserDefaultKey.isLockedOn.rawValue)
    }
}

extension UIViewController {
    func defaultPresentationStyle(){
        modalPresentationStyle = .fullScreen
    }
}

extension UIFont {
    /*
     MaisonNeue-Book
     MaisonNeue-Mono
     MaisonNeue-Light
     MaisonNeue-Demi =
     MaisonNeue-Bold = Title
     */
    
    func pageTitle(size:CGFloat? = 34) -> UIFont {
        return UIFont.systemFont(ofSize: 34, weight: .semibold)
    }
    
    func navLink(size: CGFloat? = 17) -> UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    
    func itemTitle(size: CGFloat? = 17) -> UIFont {
//        return UIFont(name: "MaisonNeue-Demi", size: 17)!
        UIFont.systemFont(ofSize: 17, weight: .medium)
    }
    
    func itemDesc(size: CGFloat? = 15) -> UIFont {
//        return UIFont(name: "MaisonNeue-book", size: 14)!
        UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    
    func formControlTitle(size: CGFloat? = 15) -> UIFont{
//        return UIFont(name:"MaisonNeue-Light", size: 15)!
        return UIFont.systemFont(ofSize: 17, weight: .medium)
    }
    
    func formControlSegmented(size: CGFloat? = 13) -> UIFont {
//        return UIFont(name: "MaisonNeue-Bold", size: size!)!
        return UIFont.systemFont(ofSize: 13, weight: .regular)
    }
    
    func textInput(size: CGFloat? = 17) -> UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    
    func tabBarTitle(size: CGFloat? = 10) -> UIFont {
//        return UIFont(name: "MaisonNeue-Light", size: size ?? 10)!
        return UIFont.systemFont(ofSize: 10, weight: .medium)
    }
}

@nonobjc extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

extension UIImageView {
    func round() {
        self.layer.cornerRadius = self.frame.size.width / 2
    }
}

extension UIView {
    func setupBorder(){
        let borderLayer = UIView()
        borderLayer.backgroundColor = .darkGray
        borderLayer.alpha = 0.5
        borderLayer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(borderLayer)
        NSLayoutConstraint.activate([
            borderLayer.heightAnchor.constraint(equalToConstant: 1),
            borderLayer.topAnchor.constraint(equalTo: bottomAnchor),
            borderLayer.leadingAnchor.constraint(equalTo: leadingAnchor),
            borderLayer.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func anchor(top: NSLayoutYAxisAnchor?,leading: NSLayoutXAxisAnchor?,bottom: NSLayoutYAxisAnchor?,trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}

extension UILabel {
    func setupLeftNavBar(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont().navLink()
        label.textColor = UIColor.systemPink
        return label
    }
}

extension UIImagePickerController {
    func pickImage(view: UIViewController){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = view as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                view.present(imagePickerController,animated: true, completion: nil)
            }
            print("Camera not available")
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            view.present(imagePickerController,animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        view.present(actionSheet,animated: true, completion: nil)
    }
}

extension String {
    var lines : [String] {
        var arrayToRet = self.components(separatedBy: "\n")
        arrayToRet = arrayToRet.filter { !$0.isEmpty }
        return arrayToRet
    }
    
    var getTitle: String {
        return self.lines.first ?? self
    }
    
    var getSummary: String {
        let string = self.replacingOccurrences(of: self.getTitle, with: "")
        let desc = string.trimmingCharacters(in: .whitespacesAndNewlines)
        return desc
    }
    
    var currentDate: String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yy HH:mm:ss"
        let dateString = df.string(from: date)
        return dateString
    }
    
    
    var getSubStringDate: String {
        let index = self.firstIndex(of: " ")
        let dateString = self[..<index!]
        return String(dateString)
    }

}

//#warning("Move Image extension to separate file")
//extension UIImage {
//    
//    struct IconConfig {
//        static let navbar = UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight.bold)
//    }
//    
//    struct ImageConfig {
//        #warning("Need to create config for bigger image")
//        static let profilePlaceHolder = UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight.bold)
//    }
//    
//    struct Common {
//        static let empty = UIImage()
//        static let newNote = UIImage(named: Constant.HeaderNoteBar.addNoteImage)
//        static let profilePlaceHolder = UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.ImageConfig.profilePlaceHolder)
//    }
//    
//    struct NavBarIcon {
//        static let createNote = UIImage(systemName: "doc.badge.plus", withConfiguration: UIImage.IconConfig.navbar)
//        static let profile = UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.IconConfig.navbar)
//    }
//    
//    struct ToolBarIcon {        
//        static let deleteNote = UIImage(systemName: "trash.circle", withConfiguration: UIImage.IconConfig.navbar)
//        static let clearText = UIImage(systemName: "xmark.circle", withConfiguration: UIImage.IconConfig.navbar)
//    }
//    
//    struct Image {
//        static let smallSymbolImage = UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.ImageConfig.profilePlaceHolder)
//    }
//    
//    struct Main {
//        static let largeAppIcon = UIImage(named: Constant.SignInSC.logoImageName)
//    }
//}
