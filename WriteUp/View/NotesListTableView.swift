//
//  ShowNotesTable.swift
//  WriteUp
//
//  Created by Ashwini shalke on 20/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
protocol noteListTableViewDelegate: AnyObject {
    func handleDidSelectRow(noteID: Int)
}

class NotesListTableView: UITableView {
    weak var noteListDelegate: noteListTableViewDelegate?
    let authorId = 2 // WIP
    var noteID: Int = 0
    var noteArray = [ListNoteData]()
    var searchNote = [ListNoteData]()
    let cellId = Constant.tableCellId.cellId
    var searching = false
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(NotesListCell.self, forCellReuseIdentifier: cellId)
        self.separatorStyle = .none
        self.delegate = self
        self.dataSource = self
        getNotesByUserID()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.initFatalError)
    }
    
    func getNotesByUserID(){
        NoteAPIService.sharedInstance.fetchNoteListByAuthorId(authorID: 2) { (notes) in
            self.noteArray = notes
            DispatchQueue.main.async { self.reloadData() }
        }
    }
    
    func deleteNoteByNoteID(noteID : Int){
        NoteAPIService.sharedInstance.deleteNoteByNoteId(httpMethod: "DELETE", noteId: noteID)
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
        return 84
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let ID = noteArray[indexPath.row].id else {return}
        noteID = ID
        print(noteID)
        noteListDelegate?.handleDidSelectRow(noteID: noteID)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            guard let ID = noteArray[indexPath.row].id else {return}
            noteID = ID
            self.noteArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            deleteNoteByNoteID(noteID: ID)
        }
    }
}
