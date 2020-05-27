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

class NotesBar: BaseView,HeaderNoteDelegate {
    weak var notedelegate: NoteBarDelegate?
    
    let cellId = "CellID"
    let headerID = "HeaderID"
    let notesLabel = NoteBarLabel(labelName: Constant.NoteBar.notesLabel)
    let showAllButton = OnboardingButton(titletext: Constant.NoteBar.showAllButton)
    
    override func setup() {
        super.setup()
        addSubview(topView)
        topView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor,padding:UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: 25))
        
        topView.addSubview(notesLabel)
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        notesLabel.anchor(top: topView.topAnchor, leading: leadingAnchor, bottom: topView.bottomAnchor, trailing: nil)
        
        topView.addSubview(showAllButton)
        showAllButton.isUserInteractionEnabled = true
        showAllButton.setTitleColor(.systemPink, for: .normal)
        
        showAllButton.addTarget(self, action: #selector(handleShowAll), for: .touchUpInside)
        showAllButton.anchor(top: topView.topAnchor, leading: notesLabel.trailingAnchor, bottom: topView.bottomAnchor, trailing: trailingAnchor,padding: UIEdgeInsets(top: 0, left: 125, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        addSubview(collectionView)
        collectionView.register(NoteCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderNoteBar.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        collectionView.anchor(top: topView.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor,padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    let topView: UIView = {
       let tv = UIView()
        return tv
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    @objc func handleShowAll(){
        notedelegate?.showAllNotes()
    }
    
    func addNote() {
        notedelegate?.showAddNote()
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


