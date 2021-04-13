//
//  NoteListViewCell.swift
//  WriteUp
//
//  Created by Ashwini shalke on 22/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
class NotesListCell: UITableViewCell {
    var note: ListNoteData? {
        didSet {
            if let title = note?.title {
                noteTitleLabel.text = title
            }
            if let description = note?.summery {
                noteDescription.text = description
            }
            if let dateTimeString = note?.createdAt {
                guard let index = dateTimeString.firstIndex(of: " ") else { return}
                let dateString = dateTimeString[..<index]
                dateLabel.text = String(dateString)
            }
        }
    }
    
    let customView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = Constant.AppLightGray
        return view
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
        label.text = "Top things to see during holidays in HongKong and many other places"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.font = UIFont().tabBarTitle(size: 15)
        label.textColor = .black
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
        return label
    }()
    
    func setupLayout() {
        self.addSubview(customView)
//        customView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor,padding: UIEdgeInsets(top: 8, left: 16, bottom: -8, right: -16))
//
//        customView.addSubview(roundColorBar)
//        roundColorBar.anchor(top: customView.topAnchor, leading: customView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 0),size: CGSize(width: 12, height: 12))
//
//        customView.addSubview(noteTitleLabel)
//        noteTitleLabel.anchor(top: customView.topAnchor, leading: roundColorBar.trailingAnchor, bottom: nil, trailing: customView.trailingAnchor, padding: UIEdgeInsets(top: 18 , left: 16, bottom: 0, right: -75),size: CGSize(width: 0, height: 20))
//
//        customView.addSubview(noteDescription)
//        noteDescription.anchor(top: noteTitleLabel.bottomAnchor, leading: customView.leadingAnchor, bottom: customView.bottomAnchor, trailing: customView.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 16, bottom: -18, right: -16),size: CGSize(width: 0, height: 34))
//
//        customView.addSubview(dateLabel)
//        dateLabel.anchor(top: customView.topAnchor, leading: noteTitleLabel.trailingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 16, left: 10, bottom: 0, right: -10), size: CGSize(width: 75, height: 14))
  
        addSubview(customView)
        customView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: -8))

        customView.addSubview(roundColorBar)
        roundColorBar.anchor(top: customView.topAnchor, leading: customView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 8, bottom: 0, right: 0), size: CGSize(width: 12, height: 12))

        customView.addSubview(noteTitleLabel)
        noteTitleLabel.anchor(top: customView.topAnchor, leading: roundColorBar.trailingAnchor, bottom: nil, trailing:customView.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 8, bottom: 0, right: -75), size: CGSize(width: 0, height: 20))

        customView.addSubview(noteDescription)
        noteDescription.anchor(top: noteTitleLabel.bottomAnchor, leading: roundColorBar.trailingAnchor, bottom: customView.bottomAnchor, trailing: customView.trailingAnchor, padding: UIEdgeInsets(top: -8, left: 8, bottom: -8, right: -26))
        
        customView.addSubview(dateLabel)
        dateLabel.anchor(top: customView.topAnchor, leading: noteTitleLabel.trailingAnchor, bottom: nil, trailing: customView.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 10, bottom: 0, right: -10), size: CGSize(width: 0, height: 14))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.initFatalError)
    }
}

