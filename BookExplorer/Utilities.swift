//
//  Utilities.swift
//  BookExplorer
//
//  Created by Bharat Bhushan on 04/08/17.
//  Copyright © 2017 BharatBhushan. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    // Shows activity indicator. Receives the presenter as input and adds as subview of presenter.
    static func showActivityIndicator(presentedViewController:  UIViewController) {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.center = presentedViewController.view.center
        activityIndicator.startAnimating()
        presentedViewController.view.addSubview(activityIndicator)
    }
    
    static func hideActivityIndicator(presentedViewController: UIViewController) {
        for subview in presentedViewController.view.subviews {
            if subview.isKind(of: UIActivityIndicatorView.self) {
                // Activity Indicator on this presenter.
                subview.removeFromSuperview()
            }
        }
    }
    
}
