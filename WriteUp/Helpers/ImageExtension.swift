//
//  ImageExtension.swift
//  WriteUp
//
//  Created by Ashwini shalke on 23/02/21.
//  Copyright © 2021 Ashwini Shalke. All rights reserved.
//

import UIKit

extension UIImage {
    struct IconConfig {
        static let navbar = UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight.bold)
    }
    
    struct ImageConfig {
        #warning("Need to create config for bigger image")
        static let profilePlaceHolder = UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight.bold)
    }
    
    struct Common {
        static let empty = UIImage()
        static let newNote = UIImage(named: Constant.HeaderNoteBar.addNoteImage)
        static let profilePlaceHolder = UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.ImageConfig.profilePlaceHolder)
    }
    
    struct NavBarIcon {
        static let createNote = UIImage(systemName: "doc.badge.plus", withConfiguration: UIImage.IconConfig.navbar)
        static let profile = UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.IconConfig.navbar)
    }
    
    struct ToolBarIcon {
        static let deleteNote = UIImage(systemName: "trash.circle", withConfiguration: UIImage.IconConfig.navbar)
        static let clearText = UIImage(systemName: "xmark.circle", withConfiguration: UIImage.IconConfig.navbar)
    }
    
    struct Image {
        static let smallSymbolImage = UIImage(systemName: "person.crop.circle", withConfiguration: UIImage.ImageConfig.profilePlaceHolder)
    }
    
    struct Main {
        static let largeAppIcon = UIImage(named: Constant.SignInSC.logoImageName)
    }
}
