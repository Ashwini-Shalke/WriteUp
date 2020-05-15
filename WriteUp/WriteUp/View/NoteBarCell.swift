//
//  NoteBarCell.swift
//  WriteUp
//
//  Created by Ashwini shalke on 14/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class HeaderNoteBar: BaseCell {
    let noteLabel = NoteBarLabel(labelName: "Add Note")
    
    override func setup() {
        super.setup()
        addSubview(containerView)
        containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 2))
        
        containerView.addSubview(addNoteImage)
        addNoteImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10))
        
        containerView.addSubview(noteLabel)
        noteLabel.textAlignment = .center
        noteLabel.font = UIFont().appSubTitleFont(size: 12)
        
        noteLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 9, bottom: -5, right: -9),size: CGSize(width: 0, height: 18))
    }
    
    let containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let addNoteImage: UIImageView = {
        let image = UIImage(named: "addNote")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
}

class NoteCell: BaseCell {
    let noteLabel = NoteBarLabel(labelName: "note1")
    
    override func setup() {
        super.setup()
        addSubview(noteLabel)
        noteLabel.textAlignment = .center
        noteLabel.font = UIFont().appSubTitleFont(size: 12)
        
        noteLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 9, bottom: -2, right: -9),size: CGSize(width: 0, height: 18))
    }
}

