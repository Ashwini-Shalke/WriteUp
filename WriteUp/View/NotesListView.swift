//
//  ShowNotesTable.swift
//  WriteUp
//
//  Created by Ashwini shalke on 20/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
protocol noteListViewDelegate: AnyObject {
    func handleDidSelectRow()
}

class NotesListTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    weak var noteListDelegate: noteListViewDelegate?
    let cellId = Constant.tableCellId.cellId
    var searching = false
    var searchNote = [Note]()
    var noteArray = [Note(title: "NewYork Holiday Plan", description: "Top things to see during hoildays in NewYork and many other places, time to explore New York. yippppppppppppppppeeeeeeeeeeeeeeeeeeeee!!!", date: "21/05/20"),Note(title: "Paris Holiday Plan", description: "Top things to see during hoildays in Paris and many other places", date: "24/05/20"),Note(title: "Maldives Holiday Plan", description: "Top things to see during holidays in Maldives and many other places", date: "26/05/20"),Note(title: "Indonesia Holiday Plan", description: "Top things to see during hoildays in Indonesia and many other places, time to explore New York. yippppppppppppppppeeeeeeeeeeeeeeeeeeeee!!!", date: "21/05/20"),Note(title: "US Holiday Plan", description: "Top things to see during holidays in US and many other places", date: "24/05/20"),Note(title: "Japan Holiday Plan", description: "Top things to see during hoildays in Japan and many other places", date: "26/05/20")]
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(NotesListCell.self, forCellReuseIdentifier: cellId)
        self.separatorStyle = .none
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.initFatalError)
    }
    
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
        noteListDelegate?.handleDidSelectRow()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // handle delete (by removing the data from your array and updating the tableview)
            self.noteArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [(indexPath as IndexPath)], with: .automatic)
        }
    }
    
}
