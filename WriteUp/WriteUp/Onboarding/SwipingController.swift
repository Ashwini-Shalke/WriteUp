//
//  SwipingController.swift
//  WriteUp
//
//  Created by Ashwini shalke on 20/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

protocol SwipingControllerDelegate {
    func dismissOnboardingView()
}

class SwipingController : UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var delegate: SwipingControllerDelegate?
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            let indexPath = IndexPath(item: self.pageController.currentPage, section: 0)
            self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }) { (_) in
            //TODO: handle this
        }
    }
    
    let pageData: [Page] = [
        Page(images: Constant.Pages.firstPageImageName, headerText: Constant.Pages.firstPageTitle,bodyText : Constant.Pages.firstPageDescripation),
        Page(images: Constant.Pages.secondPageImageName, headerText: Constant.Pages.secondPageTitle, bodyText: Constant.Pages.secondPageDescripation),
        Page(images: Constant.Pages.thirdPageImageName, headerText: Constant.Pages.thirdPageDescripation,bodyText: Constant.Pages.thirdPageDescripation)
    ]
    
    // controls at the bottom
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitle(Constant.Pages.prevButtonTitle, for: .normal)
        button.addTarget(self , action: #selector(HandlePrev), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private let NextButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constant.Pages.nextButtonTitle, for: .normal)
        button.setTitleColor(UIColor.mainPink, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(HandleNext), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.systemPink, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitle(Constant.Pages.skipButtonTitle, for: .normal)
        button.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSkip(){

         let homeController = HomeController()
        homeController.defaultPresenatationStyle()
        present(homeController, animated: true, completion: nil)
//        delegate?.dismissOnboardingView()
        
    }
    
    @objc func HandlePrev(){
        let prevpage : Int = max (pageController.currentPage - 1 ,0)
        let indexpath = IndexPath(item: prevpage, section: 0)
        pageController.currentPage = prevpage
        print(pageController.currentPage)
        collectionView?.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func HandleNext(){
        let nextpage : Int = min(pageController.currentPage + 1,pageController.numberOfPages - 1)
        let indexpath = IndexPath(item: nextpage, section: 0)
        pageController.currentPage = nextpage
        collectionView?.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
        if (pageController.currentPage > 0){
            previousButton.isEnabled = true
            previousButton.setTitleColor(UIColor.darkGray, for: .normal)
        }
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageController.currentPage = Int(x / view.frame.width)
    }
    
    private lazy var pageController: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pageData.count
        pc.pageIndicatorTintColor = UIColor.gray
        pc.currentPageIndicatorTintColor = UIColor.mainPink
        return pc
    }()
    
    fileprivate func bottomControlLayout(){
        let bottomStackView = UIStackView(arrangedSubviews: [previousButton,pageController,NextButton])
        bottomStackView.distribution = UIStackView.Distribution.fillEqually
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bottomStackView)
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 50)])
        
        view.addSubview(skipButton)
        NSLayoutConstraint.activate([
            skipButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -30),
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            skipButton.heightAnchor.constraint(equalToConstant: 50)])
        
    }
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        setupCollectionView()
        bottomControlLayout()
    }
    
    
    func setupCollectionView(){
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            previousButton.isEnabled = false
            previousButton.setTitleColor(UIColor.lightGray, for: .normal)
        } else {
            previousButton.isEnabled = true
            previousButton.setTitleColor(UIColor.darkGray, for: .normal)
        }
        if indexPath.row == pageData.count - 1 {
            NextButton.isEnabled = false
            NextButton.setTitleColor(UIColor.lightGray, for: .normal)
        } else {
            NextButton.isEnabled = true
            NextButton.setTitleColor(UIColor.mainPink, for: .normal)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageData.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        let page = pageData[indexPath.item]
        cell.page = page
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
        
    }
}

