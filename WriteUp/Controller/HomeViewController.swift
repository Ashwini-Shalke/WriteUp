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

class HomeViewController: UIViewController,ProfileLauncherDelegate,CalendarHeightDelegate{
    weak var homeDelegate : homeDelegate?
    var calendarHeightConstraint:NSLayoutConstraint?
    let notesLabel = SecondaryButton(titleText: Constant.NoteBar.notesLabel)
    
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
        button.backgroundColor = Constant.SecondaryColor
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
        self.noteListView.reloadData()
    }
    
    func sendCalendarHeight(height: CGFloat?) {
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseInOut, animations: {
            self.calendarHeightConstraint?.constant = height ?? 0
            let generate = UIImpactFeedbackGenerator(style: .soft)
            generate.impactOccurred()
        }, completion: nil)
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
        profileButton.addTarget(self, action: #selector(handleProfileButton), for: UIControl.Event.touchUpInside)
    }
    
    func setupNav(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = Constant.HomeSC.barLabel
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont().formControlSegmented(size: 34)]
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
        navigationController?.navigationBar.tintColor = Constant.MainColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPink,NSAttributedString.Key.font: UIFont().navLink()]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    @objc func handleProfileButton(){
        let profileLauncher = ProfileLauncher()
        profileLauncher.profileDelegate = self
        navigationController?.pushViewController(profileLauncher, animated: true)
    }
    
    func dismissHome() {
        #warning("setting the user defaults to true")        
        UserDefaults.standard.setIsSignedIn(value: true)
//        UserDefaults.standard.setIsSignedIn(value: false)
        self.homeDelegate?.handleSignOut()
    }
}

extension HomeViewController: noteListTableViewDelegate,ActivityDelegate{
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
}


