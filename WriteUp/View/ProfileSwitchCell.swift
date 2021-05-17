//
//  ProfileSwitchCell.swift
//  WriteUp
//
//  Created by Ashwini shalke on 16/03/21.
//  Copyright © 2021 Ashwini Shalke. All rights reserved.
//

import UIKit

protocol SwitchCellDelegate: AnyObject {
    func handleScreenLockDelegate(tag:Int)
}

class ProfileSwitchCell: UITableViewCell{
    weak var cellDelegate : SwitchCellDelegate?
    
    var switchLabel: UILabel = {
        let switchLabel = UILabel()
        switchLabel.textColor = .black
        switchLabel.font = UIFont.systemFont(ofSize: 18,weight: .semibold)
        switchLabel.textAlignment = .left
        switchLabel.text = Constant.ProfileSC.switchLabel
        switchLabel.translatesAutoresizingMaskIntoConstraints = false
        return switchLabel
    }()
    
    let screenLockSwitch: UISwitch = {
        let screenLock = UISwitch(frame: .zero)
        screenLock.isUserInteractionEnabled = true
        return screenLock
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupLayout()
        handleScreenLock()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.initFatalError)
    }
    
    func setupLayout(){
        self.contentView.addSubview(switchLabel)
        NSLayoutConstraint.activate([
                                        switchLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                                        switchLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 16),
                                        switchLabel.widthAnchor.constraint(equalToConstant: 200)])
        
        screenLockSwitch.addTarget(self, action: #selector(handleButtonClicked(_:)), for: .valueChanged)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func handleButtonClicked(_ sender: UIButton){
        screenLockSwitch.isOn ? UserDefaults.standard.setIsScreenLockedOn(value: true) : UserDefaults.standard.setIsScreenLockedOn(value: false)
        cellDelegate?.handleScreenLockDelegate(tag: sender.tag)
    }
    
    fileprivate func isScreenLocked() -> Bool {
        return UserDefaults.standard.isScreenLockedOn()
    }
    
    func handleScreenLock(){
        if isScreenLocked() {
            screenLockSwitch.isOn = true
        } else {
            screenLockSwitch.isOn = false
        }
    }
}

