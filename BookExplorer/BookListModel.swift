//
//  DataModel.swift
//  BookExplorer
//
//  Created by Bharat Bhushan on 01/08/17.
//  Copyright © 2017 BharatBhushan. All rights reserved.
//

import UIKit

class BookListModel: NSObject {

    var bookList = [BookModel]()
    var metadata: String?
    var nextPage: String?
    var serviceRequest = ServiceRequest()
    
    func getBookList(completion: @escaping (Bool, Error?) -> ()) {
        serviceRequest.getBookListRequest(nextPage: self.nextPage) { (json, response, error) in
            if error == nil {
                if let json = json {
                    
                    self.metadata = json["metadata"]?.stringValue ?? ""
                    self.nextPage = json["nextPage"]?.stringValue ?? ""
                    if let consumables = json["consumables"] as? [[String : AnyObject]] {
                        self.parseAndStoreBookModel(consumables)
                    }
                    
                    completion(true, nil)
                } else {
                    completion(false, error)
                }
            } else {
                completion(false, error)
            }
        }
    }
    
    
    func parseAndStoreBookModel(_ bookList: [[String: AnyObject]]) {
        
        for bookData in bookList {
            let bookMetaData = bookData["metadata"] as? [String: AnyObject]
            let authors = bookMetaData?["authors"] as? [[String: AnyObject]]
            let narrators = bookMetaData?["narrators"] as? [[String: AnyObject]]
            
            let bookModel = BookModel()
            
             authors?.forEach({
                if $0["name"] != nil && !($0["name"]?.isEmpty)! {
                    bookModel.authors = (bookModel.authors ?? "") + ($0["name"]?.stringValue)! + ","
                }
            })
            
            bookModel.authors?.characters.removeLast() // remove last "," character
            
            narrators?.forEach({
                if $0["name"] != nil && !($0["name"]?.isEmpty)! {
                    bookModel.narrators =  (bookModel.narrators ?? "") + ($0["name"]?.stringValue)! + ","
                }
            })
            
            bookModel.authors?.characters.removeLast()// remove last "," character
            
            bookModel.coverImageURL = bookMetaData?["cover"]?["url"] as? String
            
            self.bookList.append(bookModel)
        
        }
    }
    
    func getBookImage(url: String?, completion: @escaping (String?) -> ()) {
        guard let imageUrl = url else {completion(nil); return}
        
        serviceRequest.getImage(url: imageUrl) { (json, response, error) in
            if error == nil {
                    completion(json)
                } else {
                    completion("")
            }
        }
    }
}
