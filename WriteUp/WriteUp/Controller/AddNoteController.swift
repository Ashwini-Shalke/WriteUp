//
//  AddNoteController.swift
//  WriteUp
//
//  Created by Ashwini shalke on 16/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class AddNoteController: UIViewController {
    
    let nextButton = OnboardingButton(titletext: "Next")
   
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.title = "Add Note"
        navigationItem.largeTitleDisplayMode = .never
        nextButton.setTitleColor(.systemPink, for: .normal)
        nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: nextButton)
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc func handleNext(){
        let newNote = AddNewNoteController()
        navigationController?.pushViewController(newNote, animated: true)
    }
}
