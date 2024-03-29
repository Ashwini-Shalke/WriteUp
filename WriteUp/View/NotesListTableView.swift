//
//  ShowNotesTable.swift
//  WriteUp
//
//  Created by Ashwini shalke on 20/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol noteListTableViewDelegate: AnyObject {
//    func handleDidSelectRow(noteDetail:ListNoteData)
    func handleDidSelectRow(noteDetail:Note)
}

class NotesListTableView: UITableView {
    weak var noteListDelegate: noteListTableViewDelegate?
    let authorId = 2 // WIP
    var noteID: Int = 0
//    var noteArray = [ListNoteData]() , searchNote = [ListNoteData]()
    var noteArray = [Note]() , searchNote = [Note]()
    let cellId = Constant.tableCellId.cellId
    var searching = false
    var userId = String()
    var db = Firestore.firestore()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(NotesListCell.self, forCellReuseIdentifier: cellId)
        self.delegate = self
        self.dataSource = self
        self.separatorColor = UIColor.clear
        self.showsVerticalScrollIndicator = false
        
        if let user = Auth.auth().currentUser {
            userId = user.uid
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.initFatalError)
    }
    
    var noteListArray: [Note]? {
        didSet{
            guard let listArray = noteListArray else { return }
            noteArray = listArray
            DispatchQueue.main.async { self.reloadData() }
        }
    }
    
//    func deleteNoteByNoteID(noteID : Int){
    func deleteNoteByNoteID(noteID : String){
        db.collection(userId).document(noteID).delete()
//        NoteAPIService.sharedInstance.deleteNoteByNoteId(httpMethod: "DELETE", noteId: noteID)
    }
}

extension NotesListTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchNote.count
        } else {
            return noteArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NotesListCell
        cell.selectionStyle = .none
        cell.note = noteArray[indexPath.row]
        if searching {
            cell.note = searchNote[indexPath.row]
        } else {
            cell.note = noteArray[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteDetail = noteArray[indexPath.row]
        noteListDelegate?.handleDidSelectRow(noteDetail: noteDetail)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            guard let ID = noteArray[indexPath.row].id else {return}
            self.noteArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            deleteNoteByNoteID(noteID: ID)
        }
    }
}
