//
//  LabelUtility.swift
//  WriteUp
//
//  Created by Ashwini shalke on 28/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
class PrimaryLabel: UILabel {
    private var labelName = UILabel()
    init(labelName: String) {
        super.init(frame: .zero)
        self.text = labelName
        self.textColor = .systemGray
        self.font = UIFont().formControlTitle()
        self.backgroundColor = .white
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 5)
        super.drawText(in: rect.inset(by: insets))
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.initFatalError)
    }
}


class NoteBarLabel: UILabel {
    private var labelName = UILabel()
    init(labelName: String) {
        super.init(frame: .zero)
        self.text = labelName
        self.font = UIFont().formControlTitle(size: 20)
        self.backgroundColor = .white
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.initFatalError)
    }
}


