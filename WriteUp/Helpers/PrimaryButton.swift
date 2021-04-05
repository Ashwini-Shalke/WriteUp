//
//  PrimaryButton.swift
//  WriteUp
//
//  Created by Ashwini shalke on 01/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class PrimaryButton: UIButton {
    let button = UIButton()
    init(titleText: String){
        super.init(frame: .zero)
        self.backgroundColor     = Constant.SecondaryColor
        self.titleLabel?.font    = UIFont(name: "georgia", size: 20)
        self.setTitle(titleText, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.layer.borderColor   = UIColor.white.cgColor
        self.layer.cornerRadius  = 5
        self.layer.borderWidth   = 4.0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError(Constant.initFatalError)
    }
}

//class SignOutButton: UIButton {
//    let button = UIButton()
//    init(titleText: String){
//        super.init(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
//        self.backgroundColor     = Constant.SecondaryColor
//        self.titleLabel?.font    = UIFont(name: "georgia", size: 20)
//        self.setTitle(titleText, for: .normal)
//        self.setTitleColor(.white, for: .normal)
//        self.layer.borderColor   = UIColor.white.cgColor
//        self.layer.cornerRadius  = 5
//        self.layer.borderWidth   = 4.0
//        self.translatesAutoresizingMaskIntoConstraints = false
//    }
//    required init?(coder: NSCoder) {
//        fatalError(Constant.initFatalError)
//    }
//}

class SecondaryButton: UIButton {
    let button = UIButton(frame: CGRect.zero)
    init(titleText: String){
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitleColor(UIColor.black, for: .normal)
        self.titleLabel?.font = UIFont().formControlSegmented(size: 17)
        self.setTitle(titleText, for: .normal)
    }
    required init?(coder: NSCoder) {
        fatalError(Constant.initFatalError)
    }
}

class ShowAllButton: UIButton {
    let button = UIButton(frame: CGRect.zero)
    init(titleText: String){
        super.init(frame: .zero)
        self.setTitleColor(Constant.SecondaryColor, for: .normal)
        self.titleLabel?.font = UIFont().formControlSegmented()
        self.setTitle(titleText, for: .normal)
    }
    required init?(coder: NSCoder) {
        fatalError(Constant.initFatalError)
    }
}


