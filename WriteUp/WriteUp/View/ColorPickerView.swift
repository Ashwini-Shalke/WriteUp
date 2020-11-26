//
//  ColorPicker.swift
//  WriteUp
//
//  Created by Ashwini shalke on 25/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit

class ColorPickerView: BaseView {
    let cellId = Constant.tableCellId.cellId
    let colors = [UIColor.systemRed, .systemGreen, .systemBlue,.systemYellow, .systemIndigo, .systemGray, .systemPurple, .systemOrange, .systemPink, .systemTeal]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func setup() {
        super.setup()
        addSubview(collectionView)
        collectionView.register(ColorPickerCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
    }
}

extension ColorPickerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ColorPickerCell
        cell.circleView.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 20, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


class ColorPickerCell: BaseCell {
    let circleView: UIView = {
        let cV = UIView ()
        cV.backgroundColor = .systemPurple
        cV.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        cV.layer.cornerRadius = cV.frame.width/2
        return cV
    }()
    
    override func setup() {
        super.setup()
        addSubview(circleView)
        circleView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: CGSize(width: 20, height: 20))
    }
}




