//
//  NoteListViewCell.swift
//  WriteUp
//
//  Created by Ashwini shalke on 22/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
class NotesListCell: UITableViewCell {
    var note: Note? {
        didSet {
            if let title = note?.title {
                 noteTitleLabel.text = title
            }
            if let description = note?.description {
                noteDescription.text = description
            }
            if let dateString = note?.date {
                dateLabel.text = dateString
            }
        }
    }
    
    let customView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .systemGray6
        cv.layer.shadowColor = Constant.MainColor.cgColor
        cv.layer.shadowOpacity = 0.5
        cv.layer.shadowOffset = .zero
        cv.layer.shadowRadius = 2 
        cv.layer.cornerRadius = 5
        return cv
    }()
    
    let noteTitleLabel: UILabel = {
        let title = UILabel()
        title.text = "My plans for weekend"
        title.font = UIFont().itemTitle()
        title.textColor = UIColor.black
        return title
    }()
    
    let noteDescription: UILabel = {
        let label = UILabel()
        label.text = "Top things to see during hoildays in HongKong and many other places"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.font = UIFont().itemDesc()
        label.textColor = UIColor.darkGray
        return label
    }()
    
     let roundColorBar : UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 12, height: 0)
        button.layer.cornerRadius = button.frame.width/2
        button.backgroundColor = Constant.SecondaryColor
        button.isUserInteractionEnabled = false
        return button
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "20/05/20"
        label.font = UIFont().tabBarTitle()
        label.textColor = UIColor.darkGray
        return label
    }()
    
    func setupLayout() {
        self.addSubview(customView)
        customView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor,padding: UIEdgeInsets(top: 5, left: 16, bottom: -5, right: -16))
        
        customView.addSubview(roundColorBar)
        roundColorBar.anchor(top: customView.topAnchor, leading: customView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 0),size: CGSize(width: 12, height: 12))
        
        customView.addSubview(noteTitleLabel)
        noteTitleLabel.anchor(top: customView.topAnchor, leading: roundColorBar.trailingAnchor, bottom: nil, trailing: customView.trailingAnchor, padding: UIEdgeInsets(top: 8 , left: 8, bottom: 0, right: -75),size: CGSize(width: 0, height: 20))
        
        customView.addSubview(noteDescription)
        noteDescription.anchor(top: noteTitleLabel.bottomAnchor, leading: customView.leadingAnchor, bottom: nil, trailing: customView.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 12, bottom: 0, right: -10),size: CGSize(width: 0, height: 34))
        
        customView.addSubview(dateLabel)
        dateLabel.anchor(top: customView.topAnchor, leading: noteTitleLabel.trailingAnchor, bottom: nil, trailing: customView.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 12, bottom: 0, right: -10), size: CGSize(width: 0, height: 14))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
               setupLayout()
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

