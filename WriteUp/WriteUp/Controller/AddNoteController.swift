//
//  AddNoteController.swift
//  WriteUp
//
//  Created by Ashwini shalke on 16/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class AddNoteController: UIViewController {
    let nextButton = OnboardingButton(titletext: "Next")
    let titleLabel = PrimaryLabel(labelName: "Title")
    let titleTextField = PrimaryTextField(placeholderString: "Keep it short")
    let summaryLabel = PrimaryLabel(labelName: "Summary")
    let summaryTextField = PrimaryTextField(placeholderString: "Add small description")
    let chooseTagLabel = PrimaryLabel(labelName: "Choose tag")

    let titleView: UIView = UIView()
    let summaryView: UIView = UIView()
    let chooseTagView: UIView = UIView()
    
    func contructView(){
        titleView.addSubview(titleLabel)
        titleLabel.anchor(top: titleView.topAnchor, leading: titleView.leadingAnchor, bottom: nil, trailing: titleView.trailingAnchor, size: Constant.ProfileSC.Labelheight)
      
        titleView.addSubview(titleTextField)
        titleTextField.anchor(top: titleLabel.bottomAnchor, leading: titleView.leadingAnchor, bottom: nil, trailing: titleView.trailingAnchor,size: Constant.ProfileSC.TextFieldheight)
        
        summaryView.addSubview(summaryLabel)
        summaryLabel.anchor(top: summaryView.topAnchor,leading: summaryView.leadingAnchor, bottom: nil, trailing: summaryView.trailingAnchor,size: Constant.ProfileSC.Labelheight)
 
        summaryView.addSubview(summaryTextField)
        summaryTextField.anchor(top: summaryLabel.bottomAnchor, leading: summaryView.leadingAnchor, bottom: nil, trailing: summaryView.trailingAnchor,size: Constant.ProfileSC.TextFieldheight)
        

        chooseTagView.addSubview(chooseTagLabel)
        chooseTagLabel.anchor(top: chooseTagView.topAnchor, leading: chooseTagView.leadingAnchor, bottom: nil, trailing: chooseTagView.trailingAnchor, size: Constant.ProfileSC.Labelheight)
        
    }
   
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationItem.title = "Add Note"
        nextButton.setTitleColor(.systemPink, for: .normal)
        nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: nextButton)
        self.contructView()
        
        let stackView = UIStackView(arrangedSubviews: [titleView,summaryView,chooseTagView])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        // stack View :- need to calculate the number of items in stack view
        let stackHeight = CGSize(width: 0, height: (32 * 3) + (37 * 3) + 3)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: stackHeight)
    }
    
    @objc func handleNext(){
        let newNote = AddNewNoteController()
        navigationController?.pushViewController(newNote, animated: true)
    }
}
