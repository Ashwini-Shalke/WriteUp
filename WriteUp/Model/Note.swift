//
//  Note.swift
//  WriteUp
//
//  Created by Ashwini shalke on 22/05/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//
import Foundation
//struct Note {
//    var title: String?
//    var description:String?
//    var date:String?
//    init(title: String?, description:String?, date:String?) {
//        self.title = title
//        self.description = description
//        self.date = date
//    }
//}

struct NoteData :Codable {
    var title, createdAt, summery: String?
    let authorID: Int?
    let tag, body: String?
    init(title : String?, createdAt: String?, summery : String?, authorID : Int?, tag: String?, body :String?){
        self.title = title
        self.createdAt = createdAt
        self.summery = summery
        self.authorID = authorID
        self.tag = tag
        self.body = body
    }
}

struct ListNoteData: Decodable {
    var title, createdAt, summery,tag, body: String?
    let authorID,id: Int?
}


