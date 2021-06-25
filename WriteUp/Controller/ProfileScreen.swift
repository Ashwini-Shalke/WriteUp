//
//  ProfileScreen.swift
//  WriteUp
//
//  Created by Ashwini shalke on 16/03/21.
//  Copyright © 2021 Ashwini Shalke. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ProfileScreenDelegate: AnyObject {
    func dismissHome()
}

class ProfileScreen: UIViewController, UITextFieldDelegate{
    weak var profileDelegate: ProfileScreenDelegate?
    let cellID = Constant.ProfileSC.cellId
    let switchCellID = Constant.ProfileSC.switchCellID
    let profileLabel = [Constant.ProfileSC.useNameLabel, Constant.ProfileSC.emailLabel, Constant.ProfileSC.phoneLabel]
    let db = Firestore.firestore()
    var userId = String()
    var userDetails: User? {
        didSet {
            if let user = Auth.auth().currentUser {
                userId = user.uid
            }
            db.collection("Users").document(userId).setData(["firstName" : userDetails?.firstName ?? "" ,
                                                                   "lastName": userDetails?.lastName ?? " ",
                                                                   "email" : userDetails?.email ?? " ",
                                                                   "phoneNumber" : " ",
                                                                   "id": userId], merge: true)
        }
    }
    
    
    //MARK: Temporary values
//    var userDict = [0:"Ashwini Shalke", 1:"ashwini@gmail.com", 2:"9075721798", 3:"10"]
    var userDict = [Int:String]()
    
    var activeTextField = UITextField()
    var activeTextFieldBounds = CGRect()
    
    var isEditingNow: Bool? {
        didSet {
            if isEditingNow == true {
                tableView.reloadData()
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
            }
        }
    }
    
    let tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 70
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = Constant.ProfileSC.navTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(allowEditing))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setupLayout()
        tableView.tableFooterView = getFooterView()
        readUserDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readUserDetails()
    }
    
    func readUserDetails(){
        print("userId", userId)
        db.collection("Users").document("QnjBKEXEynSCxRYjCgG9uwP4vr43").getDocument { [self] (document, error) in
            if error == nil {
                if document != nil && ((document?.exists) != nil) {
                    let documentData = document?.data()
                    guard let firstName = documentData?["firstName"],let lastName = documentData?["lastName"], let email = documentData?["email"], let phoneNumber = documentData?["phoneNumber"]  else { return }
                    let fullName = "\(firstName)"+" "+"\(lastName)"
//                    self.userDict[0] = fullName
//                    self.userDict[1] = email as? String
//                    self.userDict[2] = phoneNumber as? String
                    self.userDict.updateValue(fullName, forKey: 0)
                    self.userDict.updateValue(email as! String, forKey: 1)
                    self.userDict.updateValue(phoneNumber as! String, forKey: 2)
                    DispatchQueue.main.async {
                        tableView.reloadData()
                    }
                    print("document", documentData!)
                    print("loading", userDict)
                
                }
            }
        }
    }
    
    func setupLayout(){
     view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: -20, right: -16))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileCell.self, forCellReuseIdentifier: cellID)
        tableView.register(ProfileSwitchCell.self, forCellReuseIdentifier: switchCellID)
    }
    
    func getFooterView() -> UIView {
        let footerView = UIView(frame: .zero)
        footerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let signOutButton = UIButton(frame: .zero)
        signOutButton.setTitle(Constant.ProfileSC.signOutButtonTitle, for: .normal)
        signOutButton.backgroundColor = .lightGray
        signOutButton.reversesTitleShadowWhenHighlighted = false
        signOutButton.titleLabel?.font    = UIFont(name: "georgia", size: 20)
        signOutButton.setTitleColor(.white, for: .normal)
        signOutButton.layer.borderColor   = UIColor.white.cgColor
        signOutButton.layer.cornerRadius  = 5
        signOutButton.backgroundColor     = Constant.SecondaryColor
        signOutButton.addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
        footerView.addSubview(signOutButton)
        return signOutButton
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let footer = tableView.tableFooterView {
            let newSize = footer.systemLayoutSizeFitting(CGSize(width: tableView.bounds.width, height: 10))
            footer.frame.size.height = newSize.height
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        let keyboardYAxis = self.view.frame.size.height - keyboardFrame.height
        
        let editTextFieldY: CGFloat = activeTextFieldBounds.minY
        if self.view.frame.origin.y >= 0 {
            if editTextFieldY > keyboardYAxis - 100 {
                UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editTextFieldY - (keyboardYAxis - 100)), width: self.view.bounds.width, height: self.view.bounds.height)
                }, completion: nil)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
    }
    
    @objc func handleSignOut(){
        self.navigationController?.popViewController(animated: false)
        profileDelegate?.dismissHome()
    }
    
    @objc func allowEditing(){
        isEditingNow = true
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ProfileCell {
            cell.textName.becomeFirstResponder()
        }
    }

    @objc func handleDone(){
        isEditingNow = false
        tableView.reloadData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(allowEditing))
        
    }
}

extension ProfileScreen: UITableViewDelegate,UITableViewDataSource,profileCellDelegate, SwitchCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ProfileCell
            cell.labelName.text = profileLabel[indexPath.row]
            cell.getTextValue = userDict[indexPath.row]
            cell.textName.tag = indexPath.row
            cell.cellDelegate = self
            if let state = isEditingNow {
                cell.state = state
            }
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: switchCellID, for: indexPath) as! ProfileSwitchCell
        cell.cellDelegate = self
        cell.accessoryView = cell.screenLockSwitch
        return cell
    }
    
    func handleActiveTextField(_ textField: UITextField) {
        activeTextField = textField
        activeTextFieldBounds = activeTextField.convert(activeTextField.bounds, to: self.view)
    }
    
    func handleReturnTextField(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func newData(user: [Int : String]) {
        if let name = user[0] { userDict.updateValue(name, forKey: 0) }
        
        if let email = user[1] { userDict.updateValue(email, forKey: 1) }
        
        if let phoneNumber = user[2] { userDict.updateValue(phoneNumber, forKey: 2) }
        
//        if let noteCount = user[3] { userDict.updateValue(noteCount, forKey: 3) }
//        print ("Complete User", userDict)
        print(userDict)
        
       
            let _ =  db.collection("Users").document("QnjBKEXEynSCxRYjCgG9uwP4vr43").setData(["firstName" : userDict[0] ?? " " ,
                                                                          "lastName": " ",
                                                                          "email" : userDict[1] ?? " ",
                                                                          "phoneNumber" : userDict[2] ?? " "], merge: true)
    }
     
    
    func handleScreenLockDelegate(tag: Int) {
        print("ScreenLocked Status", UserDefaults.standard.isScreenLockedOn())
    }
}
