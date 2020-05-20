//
//  Extension.swift
//  WriteUp
//
//  Created by Ashwini shalke on 15/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

extension UIColor { static let mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)}

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
    func defaultPresenatationStyle(){
        modalPresentationStyle = .fullScreen
    }
}

extension UIFont {
    func appNavFont(size: CGFloat? = 34) -> UIFont {
        return UIFont.systemFont(ofSize: size ?? 34)
    }
    
    func appMainTitleFont(size: CGFloat? = 18) -> UIFont {
        return UIFont.systemFont(ofSize: size ?? 18)
    }
    
    func appSubTitleFont(size: CGFloat? = 14) -> UIFont {
        return UIFont.systemFont(ofSize: size ?? 14)
    }
    
    func onboardingbuttonTitleFont(size: CGFloat? = 14) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size ?? 14)
    }
    
    func appLabelTitleFont(size: CGFloat? = 22) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size ?? 22)
    }
}

extension UIColor {
    func labelColor(color : UIColor? = .systemPink) -> UIColor {
        return UIColor.systemPink
    }
    
    func textFieldColor(color : UIColor? = .lightGray) -> UIColor {
        return UIColor.lightGray
    }
    
    func borderColor(color : UIColor? = .darkGray) -> UIColor {
        return UIColor.darkGray
    }
    
    func notecellColor(color: UIColor? = .systemYellow) -> UIColor {
        return UIColor.systemYellow
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
        borderLayer.backgroundColor = UIColor().borderColor()
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
        label.font = UIFont().appNavFont()
        label.textColor = UIColor.systemPink
        return label
        
    }
}

extension UIImagePickerController {
    func pickImage(view: UIViewController){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = view as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        let actionsheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                view.present(imagePickerController,animated: true, completion: nil)
            }
            print("Camera not available")
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            view.present(imagePickerController,animated: true, completion: nil)
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        view.present(actionsheet,animated: true, completion: nil)
    }
}
