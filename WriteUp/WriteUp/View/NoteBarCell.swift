//
//  NoteBarCell.swift
//  WriteUp
//
//  Created by Ashwini shalke on 14/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

protocol HeaderNoteDelegate {
    func addNote()
}

class HeaderNoteBar: BaseCell {
    var headerDelegate: HeaderNoteDelegate?
    let addNoteLabel = NoteBarLabel(labelName: Constant.HeaderNoteBar.addNoteLabel)
    
    override func setup() {
        super.setup()
        addSubview(containerView)
        containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 2))
        
        containerView.addSubview(addNoteButton)
        addNoteButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10))
        addNoteButton.addTarget(self, action: #selector(handleAddNote), for: .touchUpInside)
        
        containerView.addSubview(addNoteLabel)
        addNoteLabel.textAlignment = .center
        addNoteLabel.font = UIFont().appSubTitleFont(size: 12)
        
        addNoteLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 9, bottom: -5, right: -9),size: CGSize(width: 0, height: 18))
    }
    
    let containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let addNoteButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: Constant.HeaderNoteBar.addNoteImage)
        button.setImage(image, for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func handleAddNote() {
        headerDelegate?.addNote()
    }
}

class NoteCell: BaseCell {
    let noteLabel = NoteBarLabel(labelName: "note1")
    override func setup() {
        super.setup()
        backgroundColor = UIColor().notecellColor()
        addSubview(noteLabel)
        noteLabel.textAlignment = .center
        noteLabel.font = UIFont().appSubTitleFont(size: 12)
        noteLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 9, bottom: -2, right: -9),size: CGSize(width: 0, height: 18))
    }
}
