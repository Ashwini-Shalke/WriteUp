//
//  Home.swift
//  WriteUp
//
//  Created by Ashwini shalke on 14/04/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol homeDelegate: AnyObject{
    func handleSignOut()
}

class HomeViewController: BaseViewController, ProfileScreenDelegate {
    weak var homeDelegate : homeDelegate?
    var calendarHeightConstraint:NSLayoutConstraint?
    let notesLabel = SecondaryButton(titleText: Constant.NoteBar.notesLabel)
    //    var noteArray = [ListNoteData]()
    var noteArray = [Note]()
    let todayDate: String = ""
    var userId = String()
    let db = Firestore.firestore()
    var notes = [Note]()
    
    lazy var calendar:Calendar = {
        let cal = Calendar()
        cal.calendarDelegate = self
        return cal
    }()
    
    lazy var noteListView: NotesListTableView = {
        var noteView = NotesListTableView()
        noteView.noteListDelegate = self
        return noteView
    }()
    
    lazy var activityBar: ActivityBar = {
        var bar = ActivityBar()
        bar.activityDelegate = self
        return bar
    }()
    
    private let profileButton : UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 0)
        button.layer.cornerRadius = button.frame.width/2
        button.setImage(UIImage.NavBarIcon.profile, for: .normal)
        return button
    }()
    
    private let createNoteButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.NavBarIcon.createNote, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.delegate = self
        setupNav()
        setupActions()
        self.state = State.loading
        
        if let user = Auth.auth().currentUser {
            userId = user.uid
        }
    
        #if DEVELOPMENT
        print("DEV")
        #else
        print("prod")
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getNotesByUserID()
    }
    
    func getNotesByUserID(){
        db.collection(userId).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                DispatchQueue.main.async { self.state = State.error }
                return
            }
            self.notes = documents.compactMap({ (queryDocumentSnapshot) -> Note? in
                return try? queryDocumentSnapshot.data(as: Note.self)
            })
            self.noteArray = self.notes
            self.noteListView.noteArray = self.noteArray
            DispatchQueue.main.async { self.state = State.loaded }
            
            //        NoteAPIService.sharedInstance.fetchNoteListByAuthorId(authorID: 2) {(notes,error) in
            //            if let _ = error {
            //                DispatchQueue.main.async { self.state = State.error }
            //            } else {
            //                guard let noteList = notes else { return }
            ////                self.noteArray = noteList
            //                self.noteListView.noteArray = self.noteArray
            //                DispatchQueue.main.async { self.state = State.loaded }
            //            }
                    }
        }
        
        func setupViews(){
            view.backgroundColor = UIColor.white
            
            view.addSubview(calendar)
            calendar.translatesAutoresizingMaskIntoConstraints = false
            calendar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil ,padding: UIEdgeInsets(top: 0, left:  5, bottom: 0, right: -5))
            calendar.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
            calendarHeightConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 300)
            NSLayoutConstraint.activate([calendarHeightConstraint!])
            view.layer.layoutIfNeeded()
            
            view.addSubview(activityBar)
            activityBar.anchor(top: calendar.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,padding:UIEdgeInsets(top: 8, left: 16, bottom: 0, right: -16),size: CGSize(width: 0, height: 25))
            
            view.addSubview(notesLabel)
            notesLabel.anchor(top: activityBar.topAnchor, leading:activityBar.leadingAnchor, bottom: activityBar.bottomAnchor,trailing: nil,padding : UIEdgeInsets(top: 0, left: -16, bottom: 16, right: 0),size: CGSize(width: 100, height: 0))
            
            view.addSubview(noteListView)
            noteListView.anchor(top: activityBar.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
        }
        
        func setupActions(){
            profileButton.addTarget(self, action: #selector(handleProfileButton), for: .touchUpInside)
            createNoteButton.addTarget(self, action: #selector(handleCreateNote), for: .touchUpInside)
        }
        
        func setupNav(){
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.topItem?.title = Constant.HomeSC.barLabel
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont().formControlSegmented(size: 34)]
            navigationController?.navigationItem.largeTitleDisplayMode = .always
            navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: profileButton)
            navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: createNoteButton)
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.setBackgroundImage(UIImage.Common.empty, for: .default)
            navigationController?.navigationBar.shadowImage = UIImage.Common.empty
        }
        
        @objc func handleProfileButton(){
            let profileLauncher = ProfileScreen()
            profileLauncher.profileDelegate = self
            navigationController?.pushViewController(profileLauncher, animated: true)
        }
        
        @objc func handleCreateNote(){
            let addNewNote = AddNewNoteController()
            addNewNote.context = Constant.contextName.NewScreen
            navigationController?.pushViewController(addNewNote, animated: true)
        }
    }

extension HomeViewController: noteListTableViewDelegate,ActivityDelegate,CalendarHeightDelegate,BaseViewControllerProtocol {

    func showSuccessView() {
        setupViews()
    }
    
    func handleDidSelectDate(selectedDate: String) {
//        var list = [ListNoteData]()
        var list = [Note]()
        let selectedCalendarDate = selectedDate.getSubStringDate
        for index in self.noteArray {
//            guard  noteDate = index.createdAt else {return}
            let noteDate = index.createdAt
            
            let selectedNoteDate = noteDate?.getSubStringDate
            if selectedCalendarDate == selectedNoteDate {
                list.append(index)
            }
        }
        if (list.isEmpty) {
            let notFoundAlert = UIAlertController(title: Constant.HomeSC.notFoundAlertTitle, message: Constant.HomeSC.notFoundAlertMessage, preferredStyle: .alert)
            notFoundAlert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(notFoundAlert, animated: true, completion: nil)
        }
        DispatchQueue.main.async {
            self.noteListView.noteArray = list
            self.noteListView.reloadData()
        }
    }
    
//    func handleDidSelectRow(noteDetail: ListNoteData) {
        func handleDidSelectRow(noteDetail: Note) {
        let editNoteView = AddNewNoteController()
        editNoteView.context = Constant.contextName.EditScreen
        editNoteView.noteDetail = noteDetail
        navigationController?.pushViewController(editNoteView, animated: true)
    } 
    
    func showAllNote() {
        let showAllNotesView = ShowAllNotesController()
        navigationController?.pushViewController(showAllNotesView, animated: true)
    }
    
    func dismissHome() {
        UserDefaults.standard.setIsSignedIn(value: false)
        self.homeDelegate?.handleSignOut()
    }
    
    func sendCalendarHeight(height: CGFloat?) {
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseInOut, animations: {
            self.calendarHeightConstraint?.constant = height ?? 0
            let generate = UIImpactFeedbackGenerator(style: .soft)
            generate.impactOccurred()
        }, completion: nil)
    }
}


