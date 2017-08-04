//
//  SpinnerTableViewCell.swift
//  BookExplorerDemoApp
//
//  Created by Bharat Bhushan on 01/08/17.
//  Copyright © 2017 BharatBhushan. All rights reserved.
//

import UIKit

class SpinnerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
