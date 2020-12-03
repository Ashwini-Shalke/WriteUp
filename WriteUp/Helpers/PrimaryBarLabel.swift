//
//  PrimaryBarLabel.swift
//  WriteUp
//
//  Created by Ashwini shalke on 18/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class PrimaryBarLabel: UILabel {
    let label = UILabel()
    init(title: String){
        super.init(frame: .zero)
        self.text = title
        self.textColor = UIColor.systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.initFatalError)
    }
}
