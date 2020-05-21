//
//  ShowAllNoteController.swift
//  WriteUp
//
//  Created by Ashwini shalke on 21/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class ShowAllNotesController: UIViewController {
    let notesListView: NotesListView = {
        let notesView = NotesListView()
        
        notesView.translatesAutoresizingMaskIntoConstraints = false
        return notesView
    }()
    
    lazy var searchBar: UISearchBar = {
        var bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.showsCancelButton = true
        bar.delegate = self
        bar.tintColor = .systemPink
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchBar)
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16),size: CGSize(width: 0, height: 36))
        
        view.addSubview(notesListView)
        notesListView.anchor(top: searchBar.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
        view.backgroundColor = .white
        navigationItem.title = "Notes"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}

extension ShowAllNotesController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        notesListView.searchNote = notesListView.noteArray.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
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



