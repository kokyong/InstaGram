//
//  FollowerTableViewCell.swift
//  Insta.Gram
//
//  Created by Kok Yong on 14/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit

class FollowerTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var followerPicture: UIImageView!
    @IBOutlet weak var followerUsername: UILabel!
    @IBOutlet weak var followerDescription: UILabel!
    
    static let cellIdentifier = "FollowerTableViewCell"
    static let cellNib = UINib(nibName: "FollowerTableViewCell", bundle: Bundle.main)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
