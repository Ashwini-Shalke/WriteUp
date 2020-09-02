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
    }
    
    func setIsSignedIn(value:Bool) {
        set(value, forKey: UserDefaultKey.isSignedIn.rawValue)
        synchronize()
    }
    
    func isSignedIn() -> Bool {
        return bool(forKey: UserDefaultKey.isSignedIn.rawValue)
    }
}

extension UIViewController {
    func defaultPresentationStyle(){
        modalPresentationStyle = .fullScreen
    }
}

extension UIFont {
    func pageTitle(size:CGFloat? = 34) -> UIFont {
        return UIFont.systemFont(ofSize: 34, weight: .semibold)
    }
    
    func navLink(size: CGFloat? = 17) -> UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    
    func itemTitle(size: CGFloat? = 17) -> UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .medium)
    }
    
    func itemDesc(size: CGFloat? = 15) -> UIFont {
        return UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    
    func formControlTitle(size: CGFloat? = 17) -> UIFont{
        return UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
    
    func formControlSegmented(size: CGFloat? = 13) -> UIFont {
        return UIFont.systemFont(ofSize: 13, weight: .regular)
    }
    
    func textInput(size: CGFloat? = 17) -> UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    
    func tabBarTitle(size: CGFloat? = 10) -> UIFont {
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
    
    var title: String {
        return self.lines.first ?? self
    }
    
    var description: String {
        let string = self.replacingOccurrences(of: self.title, with: "")
        let desc = string.trimmingCharacters(in: .whitespacesAndNewlines)
        return desc
    }
}
