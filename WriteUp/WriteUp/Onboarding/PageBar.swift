//
//  SwipingView.swift
//  WriteUp
//
//  Created by Ashwini shalke on 27/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
class PageBar: UIView {
//    weak var swipingController: SwipingController?
    let previousButton = OnboardingButton(titletext: Constant.Pages.prevButtonTitle)
    let NextButton = OnboardingButton(titletext: Constant.Pages.nextButtonTitle)

    lazy var swipingController: SwipingController = {
        var sc = SwipingController()
//        sc.pageBar = self
        return sc
    }()
    
    let pageData: [Page] = [
          Page(images: Constant.Pages.firstPageImageName, headerText: Constant.Pages.firstPageTitle,bodyText : Constant.Pages.firstPageDescripation),
          Page(images: Constant.Pages.secondPageImageName, headerText: Constant.Pages.secondPageTitle, bodyText: Constant.Pages.secondPageDescripation),
          Page(images: Constant.Pages.thirdPageImageName, headerText: Constant.Pages.thirdPageDescripation,bodyText: Constant.Pages.thirdPageDescripation)
      ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bottomControlLayout()
        previousButton.isUserInteractionEnabled = true
        NextButton.isUserInteractionEnabled = true
        previousButton.addTarget(self, action: #selector(HandlePrev), for: .touchUpInside)
        NextButton.addTarget(self, action: #selector(HandleNext), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    @objc func HandlePrev(){
        let prevpage : Int = max (pageController.currentPage - 1 ,0)
        let indexpath = IndexPath(item: prevpage, section: 0)
        pageController.currentPage = prevpage
        print(pageController.currentPage)
        swipingController.collectionView.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func HandleNext(){
        let nextpage : Int = min(pageController.currentPage + 1,pageController.numberOfPages - 1)
        let indexpath = IndexPath(item: nextpage, section: 0)
        pageController.currentPage = nextpage
        swipingController.collectionView.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
        if (pageController.currentPage > 0){
            previousButton.isEnabled = true
            previousButton.setTitleColor(UIColor.darkGray, for: .normal)
        }
    }
    
    lazy var pageController: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pageData.count
        pc.pageIndicatorTintColor = UIColor.gray
        pc.currentPageIndicatorTintColor = UIColor.mainPink
        return pc
    }()
    
    func bottomControlLayout(){
        previousButton.setTitleColor(.darkGray, for: .normal)
        NextButton.setTitleColor(.systemPink, for: .normal)
        let bottomStackView = UIStackView(arrangedSubviews: [previousButton,pageController,NextButton])
        bottomStackView.distribution = UIStackView.Distribution.fillEqually
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bottomStackView)
        bottomStackView.anchor(top: nil, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, size: CGSize(width: 0, height: 50))
        
    }
}


