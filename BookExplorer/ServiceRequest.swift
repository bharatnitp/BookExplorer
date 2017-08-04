//
//  DataSourceManager.swift
//  BookExplorerDemoApp
//
//  Created by Bharat Bhushan on 01/08/17.
//  Copyright © 2017 BharatBhushan. All rights reserved.
//

import Foundation

class ServiceRequest: NSObject {

    var session: URLSession?
    
    func getBookListRequest(url: String, method: String, nextPage: String? = nil, completion: @escaping ([String: AnyObject]?, URLResponse?, Error?) -> ()) {
        
        let url = URL(string: url)
        session = URLSession.shared
        
        var request = URLRequest(url: url!)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        if let nextPage = nextPage {
            let paramString = "page = \(nextPage)"
            request.httpBody = paramString.data(using: String.Encoding.utf8)
        }
        
        let task = session?.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject]
                        completion(json, response, error)
                     } catch {
                        print(error)
                     }
                }
            } else {
                completion(nil, response, error)
            }
            
        }
        
        task?.resume()
    }
    
    func getImage(url: String, method: String, completion: @escaping (String?, URLResponse?, Error?) -> ()) {
        
        let url = URL(string: url)
        session = URLSession.shared
        
        var request = URLRequest(url: url!)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let task = session?.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let data = data {
                    do {
                        
                        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)!
                            
                            //JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject]
                        completion(json as String, response, error)
                    } catch {
                        print(error)
                    }
                }
            } else {
                completion(nil, response, error)
            }
            
        }
        
        task?.resume()
    }
}
