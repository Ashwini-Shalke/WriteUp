//
//  Home.swift
//  WriteUp
//
//  Created by Ashwini shalke on 14/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
import FSCalendar

protocol homeDelegate {
    func handleSignOut()
}

class HomeViewController: UIViewController,ProfileLauncherDelegate,FSCalendarDataSource,FSCalendarDelegate {
    var homeDelegate : homeDelegate?
    let calendar = Calendar()
    
    lazy var notesBar:NotesBar = {
        let nb = NotesBar()
        nb.notedelegate = self
        nb.translatesAutoresizingMaskIntoConstraints = false
        return nb
    }()
    
    var noteListView: NotesListView = {
       var noteView = NotesListView()
        noteView.translatesAutoresizingMaskIntoConstraints = false
        return noteView
    }()
    
    private let profileButton : UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 0)
        button.layer.cornerRadius = button.frame.width/2
        button.backgroundColor = UIColor.systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupLayout(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Write UP"
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
        profileButton.addTarget(self, action: #selector(handleProfileButton), for: UIControl.Event.touchUpInside)
    }
    
    @objc func handleProfileButton(){
        let profileLauncher = ProfileLauncher()
        profileLauncher.profiledelegate = self
        navigationController?.pushViewController(profileLauncher, animated: true)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        view.addSubview(notesBar)
        notesBar.anchor(top:view.safeAreaLayoutGuide.topAnchor,leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16), size: CGSize(width: 0, height: 200))

        view.addSubview(calendar)
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.anchor(top: notesBar.bottomAnchor, leading: nil, bottom: nil, trailing: nil ,padding: UIEdgeInsets(top: 15, left:  5, bottom: 0, right: -5),size: CGSize(width: view.frame.width, height: 300))

        view.addSubview(noteListView)
        noteListView.anchor(top: calendar.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0) ,size: CGSize(width: 0, height: 500))
        setupLayout()
    }
    
    func dismissHome() {
        UserDefaults.standard.setIsSignedIn(value: false)
        self.homeDelegate?.handleSignOut()
    }
}

extension HomeViewController: NoteBarDelegate {
    func showAddNote(){
        let addNoteView = AddNoteController()
        navigationController?.pushViewController(addNoteView, animated: true)
    }
    
    func showAllNotes() {
        let showAllNotesView = ShowAllNotesController()
        navigationController?.pushViewController(showAllNotesView, animated: true)
        
    }
  
    
}


