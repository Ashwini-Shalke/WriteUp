//
//  SwipingController.swift
//  WriteUp
//
//  Created by Ashwini shalke on 15/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

protocol onBoardingViewControllerDelegate {
    func dismissSignIn()
}

class onBoardingController: UIViewController,SwipingControllerDelegate {
    var onboardingdelegate: onBoardingViewControllerDelegate?
    
    lazy var collectionVC: UICollectionViewController = {
        let layout = UICollectionViewFlowLayout()
        let cv = SwipingController(collectionViewLayout: layout)
        cv.swipingDelegate = self
        return cv
    }()
    
    override func viewDidLoad() {
        collectionVC.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionVC.view)
        collectionVC.view.anchor(top:self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
    }
    
    func dismissOnboardingView() {
        dismiss(animated: true) {
            self.onboardingdelegate?.dismissSignIn()
        }
    }
}

