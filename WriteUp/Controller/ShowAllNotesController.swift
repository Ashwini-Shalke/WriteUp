//
//  ShowAllNoteController.swift
//  WriteUp
//
//  Created by Ashwini shalke on 21/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseAuth

class ShowAllNotesController: BaseViewController {
//    var noteArray = [ListNoteData]()
    var noteArray = [Note]()
    var db = Firestore.firestore()
    var userId = String()
  @Published var notes = [Note]()
    
    lazy var notesListView: NotesListTableView = {
        var notesView = NotesListTableView()
        notesView.noteListDelegate = self
        return notesView
    }()
    
    lazy var searchBar: UISearchBar = {
        var bar = UISearchBar()
        bar.showsCancelButton = true
        bar.delegate = self
        bar.backgroundColor = .white
        bar.tintColor = Constant.SecondaryColor
        bar.backgroundImage = UIImage.Common.empty
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.delegate = self
        state = State.loading
        if let user = Auth.auth().currentUser {
            userId = user.uid
        }
        setUpNav()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getNotesByUserID()
    }
    
    func setUpNav(){
        view.backgroundColor = .white
        navigationItem.title = Constant.ShowAllNote.barLabel
        
        view.addSubview(searchBar)
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16),size: CGSize(width: 0, height: 36))
        
    }

    func setUpViews(){
        view.addSubview(notesListView)
        notesListView.anchor(top: searchBar.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    func getNotesByUserID() {
        db.collection(userId).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                DispatchQueue.main.async { self.state = State.error }
                return
            }
            self.notes = documents.compactMap({ (queryDocumentSnapshot) -> Note? in
                return try? queryDocumentSnapshot.data(as: Note.self)
            })
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yy HH:mm:ss"
            let sortedNotes = self.notes.sorted(by: { dateFormatter.date(from:$0.createdAt!)!.compare(dateFormatter.date(from:$1.createdAt!)!) == .orderedDescending })
            self.noteArray = sortedNotes
            self.notesListView.noteListArray = self.noteArray
            DispatchQueue.main.async { self.state = State.loaded }
        }
        //     NoteAPIService.sharedInstance.fetchNoteListByAuthorId(authorID: 2) {(notes,error) in
        //            if let _ = error {
        //                DispatchQueue.main.async { self.state = State.error }
        //            } else {
        //                guard let noteList = notes else { return }
        //                self.noteArray = noteList
        //                self.notesListView.noteListArray = self.noteArray
        //                DispatchQueue.main.async { self.state = State.loaded }
        //            }
        //        }
    }
}

extension ShowAllNotesController: UISearchBarDelegate, noteListTableViewDelegate, BaseViewControllerProtocol {
    func showSuccessView() {
      setUpViews()
    }
    
//    func handleDidSelectRow(noteDetail: ListNoteData) {
    func handleDidSelectRow(noteDetail: Note) {
        let editNoteView = AddNewNoteController()
        editNoteView.noteDetail = noteDetail
        editNoteView.context = Constant.contextName.EditScreen
        navigationController?.pushViewController(editNoteView, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        notesListView.searchNote = notesListView.noteArray.filter({($0.title!.lowercased().prefix(searchText.count).elementsEqual(searchText.lowercased()))
        })
        notesListView.searching = true
        notesListView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        notesListView.searching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        notesListView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}



