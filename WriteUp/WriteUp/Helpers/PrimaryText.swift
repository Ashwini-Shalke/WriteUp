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
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
