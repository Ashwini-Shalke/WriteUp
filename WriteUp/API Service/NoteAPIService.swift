//  APIService.swift
//  WriteUp
//
//  Created by Ashwini shalke on 30/12/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.

//import UIKit
//
//class NoteAPIService: NSObject {
//    static let sharedInstance = NoteAPIService()
//    var sortedNoteArray = [ListNoteData]()
//    let baseURL = "https://bestnoteapp.herokuapp.com/"
//
//    func fetchNoteListByAuthorId(authorID: Int, completion: @escaping ([ListNoteData]?, Error?)-> ()){
//        fetchNotesFromURLString(urlString: "\(baseURL)users/\(authorID)/notes", completion: completion)
//    }
//
//    func createNote(httpMethod: String, data: NoteData) {
//        operationsOnNoteFromURLStrings(urlString: "\(baseURL)notes" , httpMethod: httpMethod, data: data)
//    }
//
//    func deleteNoteByNoteId(httpMethod: String, noteId: Int){
//        operationsOnNoteFromURLStrings(urlString: "\(baseURL)notes/\(noteId)", httpMethod: httpMethod, data: nil)
//    }
//
//    func modifyNoteByNoteId(httpMethod: String, noteId: Int, data: NoteData) {
//        operationsOnNoteFromURLStrings(urlString: "\(baseURL)notes/\(noteId)", httpMethod: httpMethod, data: data)
//    }
//
//    func fetchNotesFromURLString(urlString: String, completion : @escaping ([ListNoteData]?, Error?) -> ()) {
//        guard let url = URL(string: urlString) else {return}
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data else { return }
//            do {
//                var notesArray = try JSONDecoder().decode([ListNoteData].self, from : data)
//                DispatchQueue.main.async {
//                    notesArray.sort{"\(String(describing: $0.createdAt))" > "\(String(describing: $1.createdAt))"}
//                    completion(notesArray, nil)
//                }
//            } catch let jsonError{
//                completion(nil, jsonError)
//            }
//        }.resume()
//    }
//
//    func operationsOnNoteFromURLStrings(urlString: String, httpMethod: String, data: NoteData?) {
//        guard let url = URL(string: urlString) else { return }
//        var request = URLRequest(url: url)
//        request.httpMethod =  httpMethod
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer +Y/RdSbjir2E6wB1/8KK0w==", forHTTPHeaderField: "Authorization")
//        let parameters = data
//        guard let uploadData = try? JSONEncoder().encode(parameters) else {return}
//        URLSession.shared.uploadTask(with: request, from: uploadData) { (data, response, error) in
//            do {
//                if error != nil {
//                    print("error=\(String(describing: error))")
//                    return
//                }
//                _ = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
////                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
////                print("responseString = \(String(describing: responseString))")
//                return
//            }
//        }.resume()
//    }
//}
 
