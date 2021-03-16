//
//  ProfileScreen.swift
//  WriteUp
//
//  Created by Ashwini shalke on 16/03/21.
//  Copyright © 2021 Ashwini Shalke. All rights reserved.
//

import UIKit
protocol ProfileScreenDelegate: AnyObject {
    func dismissHome()
}

class ProfileScreen: UIViewController{
    let cellID = "CellID"
    let switchCellID = "switchCellID"
    weak var profileDelegate: ProfileScreenDelegate?
    
    let profileLabel = ["Username", "Email", "Mobile Number","Total Notes"]
    var userDict = [0:"Ashwini Shalke", 1:"ashwini@gmail.com", 2:"9075721798", 3:"10"]
    var activeTextField = UITextField()
    var activeTextFieldBounds = CGRect()
    let signOutButton = PrimaryButton(titleText: Constant.ProfileSC.signOutButtonTitle)
    
    var isEditingNow: Bool? {
        didSet {
            if true {
                tableView.reloadData()
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
            }
        }
    }
    
    let topViewContainer : UIView = {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = .systemPurple
        return topView
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 70
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(ProfileCell.self, forCellReuseIdentifier: cellID)
        tableView.register(ProfileSwitchCell.self, forCellReuseIdentifier: switchCellID)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(allowEditing))
        
        view.addSubview(topViewContainer)
        NSLayoutConstraint.activate([
                                        topViewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                        topViewContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                        topViewContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                        topViewContainer.heightAnchor.constraint(equalToConstant:175)])
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
                                        tableView.topAnchor.constraint(equalTo: topViewContainer.bottomAnchor, constant: 16),
                                        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                                        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                                        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)])
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        customView.backgroundColor = .green
        signOutButton.frame = CGRect(x: 0, y: 0, width: 800, height: 50)
        
       
        signOutButton.addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
        
        customView.addSubview(signOutButton)

        //Add that view in Table Footer View.
        tableView.tableFooterView = customView // Her
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    }

    @objc func handleDone(){
        isEditingNow = false
        tableView.reloadData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(allowEditing))
    }
}

extension ProfileScreen: UITableViewDelegate,UITableViewDataSource,profileCellDelegate, SwitchCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ProfileCell
            cell.labelName.text = profileLabel[indexPath.row]
            cell.getTextValue = userDict[indexPath.row]
            cell.textName.tag = indexPath.row
            cell.cellDelegate = self
            if let state = isEditingNow {
                cell.state = state
            }else {
                cell.state = false
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
        
        if let noteCount = user[3] { userDict.updateValue(noteCount, forKey: 3) }
        print ("Complete User", userDict)
    }
     
    func handleScreenLockDelegate(tag: Int) {
        print("*******", tag)
    }
}
