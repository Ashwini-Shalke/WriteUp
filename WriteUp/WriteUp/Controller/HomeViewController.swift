//
//  Home.swift
//  WriteUp
//
//  Created by Ashwini shalke on 14/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit


protocol homeDelegate: AnyObject{
    func handleSignOut()
}

class HomeViewController: UIViewController,ProfileLauncherDelegate {
    weak var homeDelegate : homeDelegate?
    let calendar = Calendar()
        
    lazy var notesBar:NotesBar = {
        let nb = NotesBar()
        nb.notedelegate = self
        return nb
    }()
    
   lazy var noteListView: NotesListTableView = {
       var noteView = NotesListTableView()
        noteView.noteListDelegate = self
        return noteView
    }()
    
    private let profileButton : UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 0)
        button.layer.cornerRadius = button.frame.width/2
        button.backgroundColor = UIColor.systemPink
        return button
    }()
   
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        view.addSubview(notesBar)
        setupNav()
        notesBar.anchor(top:view.safeAreaLayoutGuide.topAnchor,leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16), size: CGSize(width: 0, height: 200))

        view.addSubview(calendar)
        calendar.anchor(top: notesBar.bottomAnchor, leading: nil, bottom: nil, trailing: nil ,padding: UIEdgeInsets(top: 15, left:  5, bottom: 0, right: -5),size: CGSize(width: view.frame.width, height: 300))

        view.addSubview(noteListView)
        noteListView.anchor(top: calendar.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0) ,size: CGSize(width: 0, height: 500))
        
         profileButton.addTarget(self, action: #selector(handleProfileButton), for: UIControl.Event.touchUpInside)
        
        #if DEVELOPMENT
                   print("DEV")
               #else
                   print("prod")
               #endif
    }
    
    func setupNav(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = Constant.HomeSC.barLabel
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemIndigo, NSAttributedString.Key.font: UIFont(name: "MarkerFelt-Thin", size: 34)!]
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
        navigationController?.navigationBar.tintColor = UIColor.systemPink
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPink,NSAttributedString.Key.font: UIFont().navLink()]
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()      
    }
    
    @objc func handleProfileButton(){
        let profileLauncher = ProfileLauncher()
        profileLauncher.profiledelegate = self
        navigationController?.pushViewController(profileLauncher, animated: true)
    }
    
    func dismissHome() {
        UserDefaults.standard.setIsSignedIn(value: false)
        self.homeDelegate?.handleSignOut()
    }
}

extension HomeViewController: NoteBarDelegate, noteListViewDelegate {
    func showAddNote() {
        let addNoteView = AddNewNoteController()
        navigationController?.pushViewController(addNoteView, animated: true)
    }
    
    func showAllNotes() {
        let showAllNotesView = ShowAllNotesController()
        navigationController?.pushViewController(showAllNotesView, animated: true)
    }
  
    func handleDidSelectRow() {
//        let calEdit = TestCal()
        let editNoteView = EditNoteScreen()
        navigationController?.pushViewController(editNoteView, animated: true)
    }
}


