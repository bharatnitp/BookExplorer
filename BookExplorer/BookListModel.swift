//
//  DataModel.swift
//  BookExplorerDemoApp
//
//  Created by Bharat Bhushan on 01/08/17.
//  Copyright © 2017 BharatBhushan. All rights reserved.
//

import UIKit

class BookListModel: NSObject {

    var bookList = [BookModel]()
    var metadata: String?
    var nextPage: String?
    var number = 1000
    var serviceRequest = ServiceRequest()
    
    func getBookList(completion: @escaping (Bool, Error?) -> ()) {
        let url = "http://api.storytelbridge.com/consumables/list/1"
        serviceRequest.getBookListRequest(url: url, method: "GET", nextPage: self.nextPage) { (json, response, error) in
            if error == nil {
                if let json = json {
                    
                    self.metadata = json["metadata"]?.stringValue
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
            
            bookModel.authors =  authors?.reduce("", {(authorsString, author) in ((author["name"] as? String) ?? "" + authorsString)})
            
            bookModel.narrators = narrators?.reduce("", {(narratorsString, narattor) in ((narattor["name"] as? String) ?? ""  + narratorsString)})
            
            bookModel.coverImageURL = bookMetaData?["cover"]?["url"] as? String
            
            self.bookList.append(bookModel)
        
        }
    }
    
    func getBookImage(url: String?, completion: @escaping (String?) -> ()) {
        guard let imageUrl = url else {completion(nil); return}
        
        serviceRequest.getImage(url: imageUrl, method: "GET") { (json, response, error) in
            if error == nil {
                    completion(json)
                } else {
                    completion("")
            }
        }
    }
}
