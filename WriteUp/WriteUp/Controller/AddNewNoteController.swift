//
//  AddNewNote.swift
//  WriteUp
//
//  Created by Ashwini shalke on 20/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class AddNewNoteController: UIViewController {
    
    let textView: UITextView = {
       let textview = UITextView()
        textview.isEditable = true
        textview.font = UIFont.systemFont(ofSize: 20)
        return textview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleNewNote))
        
        view.addSubview(textView)
        textView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: -16, right: -16))
    }
    
    @objc func handleNewNote(){
        print("need to upload note")
    }
}
