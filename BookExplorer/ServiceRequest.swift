//
//  ServiceRequest.swift
//  BookExplorer
//
//  Created by Bharat Bhushan on 12/08/17.
//  Copyright © 2017 BharatBhushan. All rights reserved.
//

import UIKit
class ServiceRequest: NSObject {
    
    func getBookListRequest(nextPage: String? = nil, completion: @escaping ([String: AnyObject]?, URLResponse?, Error?) -> ()) {
        
        var url: URL?
        let session = URLSession.shared
        
        if let nextPage = nextPage {
            let urlComponent = NSURLComponents()
            urlComponent.scheme = "http"
            urlComponent.host = "api.storytelbridge.com"
            urlComponent.path = "/consumables/list/1"
            let queryItem = URLQueryItem(name: "page", value: nextPage)
            urlComponent.queryItems = [queryItem]
            url = urlComponent.url
            
        } else {
            url = URL(string: DataSource.baseURLString)
        }
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let task = session.dataTask(with: request) { (data, response, error) in
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
        
        task.resume()
    }
    
    func getImage(url: String, completion: @escaping (String?, URLResponse?, Error?) -> ()) {
        
        let url = URL(string: url)
        let session = URLSession.shared
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let data = data {
                    do {
                        
                        //Image URL is returning  html string
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
        
        task.resume()
    }
}
