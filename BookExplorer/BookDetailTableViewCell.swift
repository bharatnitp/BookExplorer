//
//  BookDetailTableViewcell.swift
//  BookExplorer
//
//  Created by Bharat Bhushan on 31/07/17.
//  Copyright © 2017 BharatBhushan. All rights reserved.
//

import UIKit

class BookDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImageView: UIWebView!
    @IBOutlet weak var bookTitleTextLabel: UILabel!
    @IBOutlet weak var authorNamesTextLabel: UILabel!
    @IBOutlet weak var narratorNamesTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //bookImageView.image = UIImage(named: "placeholder")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
