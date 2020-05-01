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
    
//    weak var signInViewController: SignInViewController?
    
    lazy var collectionVC: UICollectionViewController = {
        let layout = UICollectionViewFlowLayout()
        let cv = SwipingController(collectionViewLayout: layout)
        cv.swipingDelegate = self
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
        dismiss(animated: true) {
            self.onboardingdelegate?.dismissSignIn()
//            self.signInViewController?.dismissSignIn()
        }
    }
}

