//
//  SaveNoteView.swift
//  WriteUp
//
//  Created by Ashwini shalke on 02/12/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class SaveNoteView : BaseView {
    let titleLabel = PrimaryLabel(labelName: Constant.AddNote.titleLabel)
    let titleTextField = PrimaryTextField(placeholderString: Constant.AddNote.titleTextFieldPlaceHolder)
    let summaryLabel = PrimaryLabel(labelName: Constant.AddNote.summaryLabel)
    let summaryTextField = PrimaryTextField(placeholderString: Constant.AddNote.summaryTextFieldPlaceHolder)
    let chooseTagLabel = PrimaryLabel(labelName: Constant.AddNote.chooseTagLabel)
    let titleView: UIView = UIView()
    let summaryView: UIView = UIView()
    let chooseTagView: UIView = UIView()
    
    let colorPickerView: ColorPickerView = {
        let pickerView = ColorPickerView()
        return pickerView
    }()
    
    override func setup() {
        constructView()
    }
    
    func constructView(){
        chooseTagView.addSubview(chooseTagLabel)
                chooseTagLabel.anchor(top: chooseTagView.topAnchor, leading: chooseTagView.leadingAnchor, bottom: nil, trailing: chooseTagView.trailingAnchor, size: Constant.ProfileSC.labelHeight)
        
                chooseTagView.addSubview(colorPickerView)
                colorPickerView.anchor(top: chooseTagLabel.bottomAnchor, leading: chooseTagView.leadingAnchor, bottom: nil, trailing: chooseTagView.trailingAnchor,size: Constant.ProfileSC.textfieldHeight)
        
        let viewArray = [titleLabel,titleTextField,summaryLabel,summaryTextField,chooseTagView]
        let stackView = UIStackView(arrangedSubviews: viewArray)
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        addSubview(stackView)

        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,size: CGSize(width: 0, height: 150))
    }
}
