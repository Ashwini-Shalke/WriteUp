//
//  SwipingController.swift
//  WriteUp
//
//  Created by Ashwini shalke on 15/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit



class onBoarding: UIViewController {
  
    
    lazy var collectionVC: UICollectionViewController = {
        let layout = UICollectionViewFlowLayout()
        let cv = SwipingController(collectionViewLayout: layout)
        return cv
    }()
    
    
    override func viewDidLoad() {
        collectionVC.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionVC.view)
        
        NSLayoutConstraint.activate([
            collectionVC.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionVC.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionVC.view.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
}


class SwipingController : UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            
            let indexPath = IndexPath(item: self.pageController.currentPage, section: 0)
            self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }) { (_) in
        }
    }
    
//  let imageNames = ["bear_first","heart_second","leaf_third"]
//  let descriptionText = ["Join use today in our fun and games!", "Subscribe and get coupons on our daily events", "VIP members special services"]
    let pages = [
        Page(images: "bear_first", headerText: "Join use today in our fun and games!",bodyText : "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."),
        Page(images: "heart_second", headerText: "Subscribe and get coupons on our daily events",bodyText : "Get notified of the savings immediately when we announce them on our website. Make sure to also give us any feedback you have."),
        Page(images: "leaf_third", headerText: "VIP members special services",bodyText : " ")
        
    ]
    
    // controls at the bottom
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitle("PREV", for: .normal)
        button.addTarget(self , action: #selector(HandlePrev), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private let NextButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor.mainPink, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(HandleNext), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    @objc func HandlePrev()
    {
        
        let prevpage : Int = max (pageController.currentPage - 1 ,0)
        let indexpath = IndexPath(item: prevpage, section: 0)
        pageController.currentPage = prevpage
        print(pageController.currentPage)
        collectionView?.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func HandleNext()
    {
        let nextpage : Int = min(pageController.currentPage + 1,pageController.numberOfPages - 1)
        let indexpath = IndexPath(item: nextpage, section: 0)
        pageController.currentPage = nextpage
        collectionView?.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
        if (pageController.currentPage > 0)
        {
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
        pc.numberOfPages = pages.count
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

        }
        else
        {
            previousButton.isEnabled = true
            previousButton.setTitleColor(UIColor.darkGray, for: .normal)
        }
        
        if indexPath.row == pages.count - 1 {
            NextButton.isEnabled = false
            NextButton.setTitleColor(UIColor.lightGray, for: .normal)
            
        }
        else {
            NextButton.isEnabled = true
            NextButton.setTitleColor(UIColor.mainPink, for: .normal)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pages.count
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
//      cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
        
//       let imageName = imageNames[indexPath.item]
//       cell.bearImage.image = UIImage(named: imageName)
//       cell.descriptionTextView.text = descriptionText[indexPath.item]
        
        let page = pages[indexPath.item]
        cell.page = page
//      cell.bearImage.image = UIImage(named: page.images)
//      cell.descriptionTextView.text = page.headerText
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
        
    }
    
   
}
