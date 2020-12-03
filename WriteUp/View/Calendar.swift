//
//  Calendar.swift
//  WriteUp
//
//  Created by Ashwini shalke on 15/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
import FSCalendar

protocol CalendarHeightDelegate: AnyObject {
    func sendCalendarHeight(height: CGFloat?)
}

class Calendar: BaseView, UIGestureRecognizerDelegate {
    weak var calendarDelegate: CalendarHeightDelegate?
    weak var calendar: FSCalendar!
    let cellID = "CellID"
    
    override func setup() {
        super.setup()
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        
        addSubview(calendar)
        self.calendar = calendar
        calendar.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: cellID)
        calendar.appearance.headerTitleColor = Constant.MainColor
        calendar.appearance.selectionColor = Constant.MainColor
        calendar.appearance.weekdayTextColor =  Constant.MainColor
        calendar.appearance.todayColor = Constant.SecondaryColor
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeUp))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeDown))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.calendar.addGestureRecognizer(swipeDown)
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        let calHeight = bounds.height
        print(calHeight)
        calendarDelegate?.sendCalendarHeight(height: calHeight)
        layoutIfNeeded()
    }
    
    @objc func respondToSwipeUp(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
            case UISwipeGestureRecognizer.Direction.down:
                self.calendar.setScope(FSCalendarScope.month, animated: true)
                print("Swiped down")
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
            case UISwipeGestureRecognizer.Direction.up:
                //[self.calendar setScope:FSCalendarScopeWeek animated:YES];
                self.calendar.setScope(FSCalendarScope.week, animated: true)
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    @objc func respondToSwipeDown(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
            case UISwipeGestureRecognizer.Direction.down:
                self.calendar.setScope(FSCalendarScope.month, animated: true)
                print("Swiped down")
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
            case UISwipeGestureRecognizer.Direction.up:
                //[self.calendar setScope:FSCalendarScopeWeek animated:YES];
                self.calendar.setScope(FSCalendarScope.week, animated: true)
                print("Swiped up")
            default:
                break
            }
        }
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
