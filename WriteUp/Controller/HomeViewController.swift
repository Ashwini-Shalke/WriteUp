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

class HomeViewController: UIViewController{
    weak var homeDelegate : homeDelegate?
    var calendarHeightConstraint:NSLayoutConstraint?
    let notesLabel = SecondaryButton(titleText: Constant.NoteBar.notesLabel)
    var noteArray = [ListNoteData]()
    let todayDate: String = ""
    
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
        setupNav()
        setupViews()
        setupActions()
        
        #if DEVELOPMENT
        print("DEV")
        #else
        print("prod")
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.noteListView.getNotesByUserID()
        getNotesByUserID()
    }
    
    func getNotesByUserID(){
        NoteAPIService.sharedInstance.fetchNoteListByAuthorId(authorID: 2) { (notes) in
            self.noteArray = notes
        }
    }
    
    func setupViews(){
        view.backgroundColor = UIColor.white
        view.addSubview(calendar)
        calendar.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil ,padding: UIEdgeInsets(top: 0, left:  5, bottom: 0, right: -5))
        calendar.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        calendarHeightConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 300)
        NSLayoutConstraint.activate([calendarHeightConstraint!])
        view.layer.layoutIfNeeded()
        
        view.addSubview(activityBar)
        activityBar.anchor(top: calendar.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,padding:UIEdgeInsets(top: 5, left: 16, bottom: 0, right: -16),size: CGSize(width: 0, height: 25))
        view.addSubview(notesLabel)
        notesLabel.anchor(top: activityBar.topAnchor, leading:activityBar.leadingAnchor, bottom: activityBar.bottomAnchor,trailing: nil,padding : UIEdgeInsets(top: 0, left: -16, bottom: 16, right: 0),size: CGSize(width: 100, height: 0))
        
        view.addSubview(noteListView)
        noteListView.anchor(top: activityBar.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0) ,size: CGSize(width: 0, height: 500))
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
        let profileLauncher = ProfileLauncher()
        profileLauncher.profileDelegate = self
        navigationController?.pushViewController(profileLauncher, animated: true)
    }
    
    @objc func handleCreateNote(){
        let addNewNote = AddNewNoteController()
        addNewNote.context = Constant.contextName.NewScreen
        navigationController?.pushViewController(addNewNote, animated: true)
    }
    
    func showNotesFor(currentDate: String){
        var noteListForCurrentDate = [ListNoteData]()
        let displayedCurrentDate = currentDate.getSubStringDate
        for index in self.noteArray {
            guard let noteDate = index.createdAt else { return }
            let selectedNoteDate = noteDate.getSubStringDate
            if displayedCurrentDate == selectedNoteDate {
                noteListForCurrentDate.append(index)
            }
        }
        DispatchQueue.main.async {
            self.noteListView.noteArray = noteListForCurrentDate
            self.noteListView.reloadData()
        }
    }
}

extension HomeViewController: noteListTableViewDelegate,ActivityDelegate,ProfileLauncherDelegate,CalendarHeightDelegate {
    
    func handleDidSelectDate(selectedDate: String) {
        var list = [ListNoteData]()
        let selectedCalendarDate = selectedDate.getSubStringDate
        for index in self.noteArray {
            guard let noteDate = index.createdAt else { return }
            let selectedNoteDate = noteDate.getSubStringDate
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
    
    func handleDidSelectRow(noteDetail: ListNoteData) {
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
        #warning("setting the user defaults to true")
        UserDefaults.standard.setIsSignedIn(value: true)
        //        UserDefaults.standard.setIsSignedIn(value: false)
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


