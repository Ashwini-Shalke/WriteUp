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
    func handleNewNote()
}

class ActivityBar: BaseView {
    weak var activityDelegate:ActivityDelegate?
    let newNoteButton = SecondaryButton(titleText: Constant.NoteBar.notesLabel)
    let showAllButton = ShowAllButton(titleText: Constant.NoteBar.showAllButton)
    let topView: UIView = {
        let tv = UIView()
        return tv
    }()
    
    override func setup() {
        super.setup()
        addSubview(topView)
        topView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor,padding:UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: 25))
        
        topView.addSubview(newNoteButton)
        newNoteButton.anchor(top: topView.topAnchor, leading: topView.leadingAnchor, bottom: topView.bottomAnchor, trailing: nil)
        newNoteButton.addTarget(self, action: #selector(handleNewNote), for: .touchUpInside)
        
        topView.addSubview(showAllButton)
        showAllButton.anchor(top: topView.topAnchor, leading: nil, bottom: topView.bottomAnchor, trailing: topView.trailingAnchor,size: CGSize(width: 70, height: 0))
        showAllButton.addTarget(self, action: #selector(handleShowAll), for: .touchUpInside)
    }
    
    @objc func handleShowAll(){
        activityDelegate?.showAllNote()
    }
    
    @objc func handleNewNote(){
        activityDelegate?.handleNewNote()
    }
}

