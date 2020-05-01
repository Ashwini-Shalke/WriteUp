//
//  PrimaryButton.swift
//  WriteUp
//
//  Created by Ashwini shalke on 01/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class PrimaryButton : UIButton {
    let button = UIButton()
    
    init(titletext: String){
        super.init(frame: .zero)
        self.backgroundColor     = UIColor.systemPink
        self.titleLabel?.font    = UIFont(name: "georgia", size: 20)
        self.setTitle(titletext, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.layer.borderColor   = UIColor.white.cgColor
        self.layer.cornerRadius  = 25
        self.layer.borderWidth   = 4.0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
