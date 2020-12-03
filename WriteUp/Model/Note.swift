//
//  Note.swift
//  WriteUp
//
//  Created by Ashwini shalke on 22/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import Foundation

struct Note {
    var title: String?
    var description:String?
    var date:String?
    init(title: String?, description:String?, date:String?) {
        self.title = title
        self.description = description
        self.date = date
    }
}
