//
//  File.swift
//  WriteUp
//
//  Created by Ashwini shalke on 06/08/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

protocol ActivityDelegate: AnyObject {
    func showAllNote()
}

class ActivityBar: BaseView {
    weak var activityDelegate:ActivityDelegate?
    let notesLabel = NoteBarLabel(labelName: Constant.NoteBar.notesLabel)
    let showAllButton = OnboardingButton(titleText: Constant.NoteBar.showAllButton)
    let topView: UIView = {
          let tv = UIView()
           return tv
       }()
    
    override func setup() {
        super.setup()
        addSubview(topView)
        topView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor,padding:UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: 25))
        
        topView.addSubview(notesLabel)
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        notesLabel.anchor(top: topView.topAnchor, leading: leadingAnchor, bottom: topView.bottomAnchor, trailing: nil)
        
        topView.addSubview(showAllButton)
        showAllButton.isUserInteractionEnabled = true
        showAllButton.setTitleColor(.black, for: .normal)
        
        showAllButton.addTarget(self, action: #selector(handleShowAll), for: .touchUpInside)
        showAllButton.anchor(top: topView.topAnchor, leading: notesLabel.trailingAnchor, bottom: topView.bottomAnchor, trailing: trailingAnchor,padding: UIEdgeInsets(top: 0, left: 125, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
    }
    
    @objc func handleShowAll(){
        activityDelegate?.showAllNote()
    }
}

