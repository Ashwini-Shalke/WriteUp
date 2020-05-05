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

class SwipingController : UICollectionViewController {
    var swipingDelegate: SwipingControllerDelegate?
    let cellID = "cellId"
    
    lazy var pageBar: PageBar = {
        var pb = PageBar()
        pb.swipingController = self
        pb.translatesAutoresizingMaskIntoConstraints = false
        return pb
    }()
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            let indexPath = IndexPath(item: self.pageBar.pageController.currentPage, section: 0)
            self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }) { (_) in
            //TODO: handle this
        }
    }
    
    let skipButton = OnboardingButton(titletext:Constant.Pages.skipButtonTitle)
    
    fileprivate func setUpLayout(){
        view.addSubview(skipButton)
        skipButton.setTitleColor(.systemPink, for: .normal)
        skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        skipButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -30),size: CGSize(width: 0, height: 50))
    }
    
    @objc func handleSkip(){
           swipingDelegate?.dismissOnboardingView()
       }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        setupCollectionView()
        view.addSubview(pageBar)
        pageBar.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        setUpLayout()
    }
    
    func setupCollectionView(){
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.isPagingEnabled = true
    }
}


extension SwipingController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageBar.pageData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PageCell
        let page = pageBar.pageData[indexPath.item]
        cell.page = page
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        self.pageBar.pageController.currentPage = Int(x / view.frame.width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            pageBar.previousButton.isEnabled = false
            pageBar.previousButton.setTitleColor(UIColor.lightGray, for: .normal)
        } else {
            pageBar.previousButton.isEnabled = true
            pageBar.previousButton.setTitleColor(UIColor.darkGray, for: .normal)
        }
        if indexPath.row == pageBar.pageData.count - 1 {
            pageBar.NextButton.isEnabled = false
            pageBar.NextButton.setTitleColor(UIColor.lightGray, for: .normal)
        } else {
            pageBar.NextButton.isEnabled = true
            pageBar.NextButton.setTitleColor(UIColor.mainPink, for: .normal)
        }
        
        if indexPath.row == pageBar.pageData.count - 1 {
            skipButton.setTitle(Constant.Pages.doneButtonTitle, for: .normal)
        }else {
            skipButton.setTitle(Constant.Pages.skipButtonTitle, for: .normal)
        }
    }
}

