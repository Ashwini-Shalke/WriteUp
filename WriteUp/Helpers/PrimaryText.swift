//
//  PrimaryText.swift
//  WriteUp
//
//  Created by Ashwini shalke on 29/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class PrimaryTextField: UITextField {
    private var textFiled = UITextField()
    init(placeholderString: String) {
        super.init(frame: .zero)
        let borderLayer = UIView()
        borderLayer.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = false
        self.clearButtonMode = .whileEditing
        self.placeholder = placeholderString
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont().textInput()
//        self.useUnderline()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.initFatalError)
    }
}

extension UITextField {
  func useUnderline() -> Void {
    let border = CALayer()
    let borderWidth = CGFloat(2.0) // Border Width
    border.borderColor = UIColor.red.cgColor
    border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
    border.borderWidth = borderWidth
    self.layer.addSublayer(border)
    self.layer.masksToBounds = true
  }
}
