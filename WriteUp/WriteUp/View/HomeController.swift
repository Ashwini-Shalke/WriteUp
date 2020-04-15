//
//  Home.swift
//  WriteUp
//
//  Created by Ashwini shalke on 14/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    var user: User?
    
    var homeView: UIView = {
        let home = UIView()
        home.backgroundColor = UIColor.systemPink
        home.translatesAutoresizingMaskIntoConstraints = false
        return home
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(homeView)
    }
    
    
    
    
}
