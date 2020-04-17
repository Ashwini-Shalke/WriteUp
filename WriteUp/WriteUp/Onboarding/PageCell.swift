//
//  PageCell.swift
//  WriteUp
//
//  Created by Ashwini shalke on 15/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class PageCell : UICollectionViewCell{
    
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else {return}
            bearImage.image = UIImage(named: unwrappedPage.images)
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes : [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            attributedText.append(NSAttributedString(string: "\n\n\(unwrappedPage.bodyText)", attributes : [NSAttributedString.Key.font
                : UIFont.systemFont(ofSize: 13)]))
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
            }
    }
    
// init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(topImageContainerView)
        topImageContainerView.addSubview(bearImage)
        layout()
    }
    
   private let bearImage: UIImageView = {
        let imageview = UIImageView(image:#imageLiteral(resourceName: "bear_first"))
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    private let topImageContainerView : UIView = {
        let topview = UIView()
        topview.translatesAutoresizingMaskIntoConstraints = false
        return topview
        
    }()
    
   private let descriptionTextView: UITextView = {
        let textView =  UITextView()
        let attributedText = NSMutableAttributedString(string: "Work is fun, join us for more fun", attributes : [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        attributedText.append(NSAttributedString(string: "\n\nAre you ready for loads and loads of fun ? Come lets join our stores for more fun", attributes : [NSAttributedString.Key.font
            : UIFont.systemFont(ofSize: 13)]))
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
    textView.backgroundColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
  

    
    private func layout() {
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        bearImage.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        bearImage.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        bearImage.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



