//
//  NoteBarCell.swift
//  WriteUp
//
//  Created by Ashwini shalke on 14/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

protocol HeaderNoteDelegate: AnyObject {
    func addNote()
}

class BaseCell: UICollectionViewCell {
  override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
  }
    
  func setup(){}
  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}

class HeaderNoteBar: BaseCell {
   weak var headerDelegate: HeaderNoteDelegate?
   let addNoteLabel = NoteBarLabel(labelName: Constant.HeaderNoteBar.addNoteLabel)
    
   let containerView: UIView = {
          let v = UIView()
          v.backgroundColor = .white
          return v
      }()
      
      let addNoteButton: UIButton = {
          let button = UIButton()
          let image = UIImage(named: Constant.HeaderNoteBar.addNoteImage)
          button.setImage(image, for: .normal)
          button.contentMode = .scaleAspectFit
          return button
      }()
    
    override func setup() {
        super.setup()
        addSubview(containerView)
        containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 2))
        
        containerView.addSubview(addNoteButton)
        addNoteButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10))
        addNoteButton.addTarget(self, action: #selector(handleAddNote), for: .touchUpInside)
        
        containerView.addSubview(addNoteLabel)
        addNoteLabel.textAlignment = .center
        addNoteLabel.font = UIFont().tabBarTitle()
        
        addNoteLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 9, bottom: -5, right: -9),size: CGSize(width: 0, height: 18))
    }
    
    @objc func handleAddNote() {
        headerDelegate?.addNote()
    }
}

class NoteCell: BaseCell {
    let noteLabel = NoteBarLabel(labelName: "note1")
    
    override func setup() {
        super.setup()
        backgroundColor = .white
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 2
        
        addSubview(noteLabel)
        noteLabel.textAlignment = .center
        noteLabel.font = UIFont().tabBarTitle()
        noteLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 9, bottom: -2, right: -9),size: CGSize(width: 0, height: 18))
    }
}

