//
//  PageCell.swift
//  WriteUp
//
//  Created by Ashwini shalke on 15/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

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
class PageCell: BaseCell{
    
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else {return}
            bearImage.image = UIImage(named: unwrappedPage.images)
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes : [NSAttributedString.Key.font: UIFont().appMainTitleFont()])
            attributedText.append(NSAttributedString(string: "\n\n\(unwrappedPage.bodyText)", attributes : [NSAttributedString.Key.font
                : UIFont().appSubTitleFont()]))
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
            }
    }
    private let bearImage: UIImageView = {
        let image = UIImage(named: Constant.Pages.firstPageImageName)
        let imageview = UIImageView(image: image)
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
    let attributedText = NSMutableAttributedString(string: Constant.Pages.firstPageTitle, attributes : [NSAttributedString.Key.font: UIFont().appMainTitleFont()])
    attributedText.append(NSAttributedString(string: "\n\n \(Constant.Pages.firstPageDescripation)", attributes : [NSAttributedString.Key.font
        : UIFont().appSubTitleFont()]))
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
    textView.backgroundColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    

    override func setup() {
        super.setup()
        addSubview(topImageContainerView)
        topImageContainerView.addSubview(bearImage)
        topImageContainerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor)
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        topImageContainerView.addSubview(bearImage)
        bearImage.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        bearImage.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        bearImage.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
      
        
        addSubview(descriptionTextView)
        descriptionTextView.anchor(top: topImageContainerView.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 24, bottom: -100, right: -24))
    }

}



