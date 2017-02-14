//
//  CommentsTableViewCell.swift
//  Insta.Gram
//
//  Created by Seow Yung Hoe on 14/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var displayPictureImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var commentsLabel: UILabel!
    
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static let cellIdentifier = "CommentsTableViewCell"
    static let cellNib = UINib(nibName: "CommentsTableViewCell", bundle: Bundle.main)
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
