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
    
    func appTitleFont(size: CGFloat? = 18) -> UIFont {
        return UIFont.systemFont(ofSize: size ?? 18)
    }
    
    func appSubTitleFont(size: CGFloat? = 14) -> UIFont {
        return UIFont.systemFont(ofSize: size ?? 14)
    }
    
    func boldTitleFont(size: CGFloat? = 22) -> UIFont {
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
