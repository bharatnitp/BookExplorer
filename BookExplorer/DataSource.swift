//
//  DataSource.swift
//  BookExplorer
//
//  Created by Bharat Bhushan on 04/08/17.
//  Copyright © 2017 BharatBhushan. All rights reserved.
//

import UIKit

class DataSource: NSObject {
    
    static var baseURLString: String {
        
        guard let dataSourcePath = Bundle.main.path(forResource: "datasource", ofType: "plist"),
            let params = NSDictionary(contentsOfFile: dataSourcePath),
            let proto = params["protocol"],
            let host = params["host"] else {
                fatalError("Cannot find the 'datasource.plist' or required parameters")
        }
        return "\(proto)://\(host)"
    }
}
