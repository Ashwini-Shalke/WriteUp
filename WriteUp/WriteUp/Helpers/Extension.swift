//
//  Extension.swift
//  WriteUp
//
//  Created by Ashwini shalke on 15/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

extension UIColor {
    static let mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}

extension UserDefaults {
    enum UserDefaultKey: String {
        case isSignedIn
    }
    
    func setIsSignedIn(value:Bool){
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
    
    func appFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    func appTitleFont(size: CGFloat? = 18) -> UIFont {
        return UIFont.systemFont(ofSize: size ?? 18)
    }
    
    func appSubTitleFont(size: CGFloat? = 14) -> UIFont {
        return UIFont.systemFont(ofSize: size ?? 14)
    }
    
    func buttonBoldSystemFont(size: CGFloat?) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size ?? 14)
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


extension UINavigationBar{
    func setTransparentNavigationBar(){
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
        backgroundColor = .clear
    }
}

