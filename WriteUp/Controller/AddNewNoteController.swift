//
//  AddNewNote.swift
//  WriteUp
//
//  Created by Ashwini shalke on 20/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift

class AddNewNoteController: UIViewController, UITextViewDelegate, bottomToolBarDelegate {
    var textfieldHeightConstraint:NSLayoutConstraint?
    var textfieldHeightWithKeyboard = (UIScreen.main.bounds.height)
    var textfieldHeightWithoutKeyboard = (UIScreen.main.bounds.height - 50)
    var verticalSafeAreaInset = CGFloat()
    let saveButton = SecondaryButton(titleText: Constant.AddNote.saveButtonTitle)
    var context = Constant.contextName.NewScreen
    let createDate : String = " "
    var noteBody, noteTitle, noteSummary : String?
    var noteId : Int = 0
//    var noteDetail = ListNoteData(title: nil, createdAt: nil, summery: nil, tag: nil, body: nil, authorID: nil, id: nil)
    var noteDetail = Note(id: nil, title: nil, summary: nil, body: nil, colorTag: nil, createdAt: nil)
    var userId = String()
    let db = Firestore.firestore()

    lazy var inputAccesssoryToolView: BottomToolBar = {
        var  toolView = BottomToolBar()
        toolView.toolbarDelegate = self
        toolView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        return toolView
    }()
    
    lazy var bottomToolBar : BottomToolBar = {
        var bottomBar = BottomToolBar()
        bottomBar.toolbarDelegate = self
        return bottomBar
    }()
    
    let textView: UITextView = {
        let textview = UITextView()
        textview.allowsEditingTextAttributes = true
        textview.font = UIFont().textInput()
        textview.keyboardDismissMode = .interactive
        textview.backgroundColor = .white
        return textview
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont().formControlSegmented()
        label.textColor = Constant.SecondaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: 154, height: 0)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setUpScreenButtons()
        if let user = Auth.auth().currentUser {
            userId = user.uid
        }
    }
    
    func setUpScreenButtons(){
        if context == Constant.contextName.NewScreen {
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
            saveButton.setTitleColor(Constant.MainColor, for: .normal)
            saveButton.addTarget(self, action: #selector(handleNewNote), for: .touchUpInside)
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
            saveButton.setTitleColor(Constant.MainColor, for: .normal)
            saveButton.addTarget(self, action: #selector(handleSaveNote), for: .touchUpInside)
        }
    }
    
    override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *){
            verticalSafeAreaInset = self.view.safeAreaInsets.top + self.view.safeAreaInsets.bottom
        } else {
            verticalSafeAreaInset = self.view.safeAreaInsets.top
        }
        view.addSubview(textView)
        textView.anchor(top: view.safeAreaLayoutGuide.topAnchor,leading: view.safeAreaLayoutGuide.leadingAnchor,bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,padding: UIEdgeInsets(top: -50,left: 16,bottom: 0,right: -16))
        textfieldHeightConstraint = NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: textfieldHeightWithoutKeyboard - verticalSafeAreaInset)
        NSLayoutConstraint.activate([ textfieldHeightConstraint! ])
        view.layer.layoutIfNeeded()
    }
    
    func setupViews(){
        view.backgroundColor = .white
        navigationItem.titleView = dateLabel
        view.addSubview(bottomToolBar)
        bottomToolBar.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 50, left: 0, bottom: -1, right: 0))
        bottomToolBar.hideBackground()
        textView.text = noteDetail.body
        dateLabel.text = noteDetail.createdAt
    }
    
    func setNoteDetails(){
        noteBody = textView.text
        noteTitle = noteBody?.getTitle
        noteSummary = noteBody?.getSummary
    }
    
    func trashButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func clearButton() {
        if textView.text != "" {
            textView.text = ""
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        textView.resignFirstResponder()
    }
    
    @objc func handleNewNote(){
        self.view.endEditing(true)
        setNoteDetails()
        //        let parameters = NoteData(title: noteTitle, createdAt: createDate.currentDate , summery: noteSummary, authorID: 2, tag: "lo", body: noteBody)
        //        NoteAPIService.sharedInstance.createNote(httpMethod: "POST", data: parameters)
        guard let tile = noteTitle, let summary = noteSummary, let body = noteBody else { return }
        addNote(note: Note(title: tile, summary: summary, body: body, colorTag: "red", createdAt: createDate.currentDate))
        navigationController?.popViewController(animated: true)
    }
    
    func addNote(note: Note){
        do {
            let _ =  try db.collection(userId).addDocument(from: note)
        } catch {
            
        }
    }
    
    @objc func handleSaveNote(){
        self.view.endEditing(true)
        setNoteDetails()
        guard let id = noteDetail.id else {return}
        //        let uploadData = NoteData(title: noteTitle, createdAt: createDate.currentDate,summery: noteSummary,authorID: 2, tag: "lo", body: noteBody)
        //        NoteAPIService.sharedInstance.modifyNoteByNoteId(httpMethod: "PATCH", noteId: noteId, data: uploadData)
        guard let tile = noteTitle, let summary = noteSummary, let body = noteBody else { return }
        modifyNote(id: id, note: Note(title: tile, summary: summary, body: body, colorTag: "red", createdAt: createDate.currentDate))
        dateLabel.text = createDate.currentDate
        navigationController?.popViewController(animated: true)
    }
    
    func modifyNote(id: String, note: Note){
        do {
            let _ =  try db.collection(userId).document(id).setData(from: note, merge: true)
        } catch {
            
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        let textfieldHeightWithKeyboard = (self.textfieldHeightWithKeyboard - verticalSafeAreaInset) -  keyboardFrame!.height
        UIView.animate(withDuration: keyboardDuration!) {
            self.textfieldHeightConstraint?.constant = textfieldHeightWithKeyboard
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        self.textfieldHeightConstraint?.constant = self.textfieldHeightWithoutKeyboard - self.verticalSafeAreaInset
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        UIView.animate(withDuration: keyboardDuration!) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension AddNewNoteController {
    override var inputAccessoryView: UIView? {
        get {
            inputAccesssoryToolView.hideBackground()
            return self.inputAccesssoryToolView
        }
    }
    
    override func resignFirstResponder() -> Bool {
        return true
    }
}
