//
//  HeaderTableViewCell.swift
//  BookExplorerDemoApp
//
//  Created by Bharat Bhushan on 04/08/17.
//  Copyright © 2017 BharatBhushan. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleTextLabel: UILabel!
    
    func configureHeaderView() {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
