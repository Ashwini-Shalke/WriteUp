//
//  NotesBar.swift
//  WriteUp
//
//  Created by Ashwini shalke on 12/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
protocol NoteBarDelegate: AnyObject {
    func showAddNote()
    func showAllNotes()
}

class NotesBar: BaseView,HeaderNoteDelegate,ActivityDelegate {
    let cellId = "CellID"
    let headerID = "HeaderID"
    weak var noteDelegate: NoteBarDelegate?
    
    lazy var activityBar: ActivityBar = {
       var bar = ActivityBar()
        bar.activityDelegate = self
       return bar
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.bounces = false
        return cv
    }()
    
    override func setup() {
        super.setup()
        addSubview(activityBar)
        activityBar.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor,padding:UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: 25))

        addSubview(collectionView)
        collectionView.register(NoteCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderNoteBar.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        collectionView.anchor(top: activityBar.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor,padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
    }
 
    func addNote() {
        noteDelegate?.showAddNote()
    }
    
    func showAllNote() {
       noteDelegate?.showAllNotes()
    }
}

extension NotesBar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId , for: indexPath) as! NoteCell
        return cell
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 102, height: 145)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! HeaderNoteBar
        header.headerDelegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 102, height: 145)
    }
}


