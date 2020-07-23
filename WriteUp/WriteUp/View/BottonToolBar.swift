//
//  ToolBar.swift
//  WriteUp
//
//  Created by Ashwini shalke on 08/06/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

protocol bottomToolBarDelegate : AnyObject {
    func trashButton()
    func clearButton()
}

class BottomToolBar: UIToolbar {
    
    weak var toolbarDelegate: bottomToolBarDelegate?
    let toolBar = UIToolbar()
    
    func setupBarButtons(){
        toolBar.frame = CGRect(x: 0.0,y: 0.0,width: UIScreen.main.bounds.size.width,height: 44.0)
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let trashButton = UIBarButtonItem(image: UIImage(named: "trash"), style: .plain, target:self, action: #selector(handleTrashButton))
        trashButton.tintColor = .systemPink
        let clearButton = UIBarButtonItem(title: "clear", style: .plain, target: self, action: #selector(handleClearButton))
        clearButton.tintColor = .systemPink
        toolBar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        toolBar.setShadowImage(UIImage(), forToolbarPosition: UIBarPosition.any)
        toolBar.setItems([trashButton,flexible, clearButton], animated: false)
        addSubview(toolBar)
    }
    
    func hideBackground(){
        setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        setShadowImage(UIImage(), forToolbarPosition: UIBarPosition.any)
    }
    
    @objc func handleTrashButton(){
        toolbarDelegate?.trashButton()
    }
    
    @objc func handleClearButton(){
        toolbarDelegate?.clearButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBarButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
