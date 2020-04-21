//
//  SwipingController.swift
//  WriteUp
//
//  Created by Ashwini shalke on 15/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

protocol onBoardingViewControllerDelegate {
    func showHome()
}

class onBoarding: UIViewController, SwipingControllerDelegate {
    
    var delegate: onBoardingViewControllerDelegate?
    
    lazy var collectionVC: UICollectionViewController = {
        let layout = UICollectionViewFlowLayout()
        let cv = SwipingController(collectionViewLayout: layout)
        cv.delegate = self
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
    
    func dismissOnboardingView() {
//        self.dismiss(animated: true) {
//            self.delegate?.showHome()
//        }
    }
}

