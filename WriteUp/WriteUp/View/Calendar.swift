//
//  Calendar.swift
//  WriteUp
//
//  Created by Ashwini shalke on 15/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
import FSCalendar

class Calendar: BaseView, UIGestureRecognizerDelegate {
    weak var calendar: FSCalendar!
    let cellID = "CellID"
    
    override func setup() {
        super.setup()
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        addSubview(calendar)
        self.calendar = calendar
        self.calendar.setScope(.week, animated: true)
        calendar.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: cellID)
    }
}

extension Calendar: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: cellID, for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        let dateString = formatter1.string(from: date)
        print(dateString)
    }
}



