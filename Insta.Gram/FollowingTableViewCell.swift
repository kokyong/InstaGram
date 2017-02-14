//
//  FollowingTableViewCell.swift
//  Insta.Gram
//
//  Created by Kok Yong on 14/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit

class FollowingTableViewCell: UITableViewCell {

    
    //IBOutlet
    @IBOutlet weak var followingPicture: UIImageView!
    @IBOutlet weak var followingUsername: UILabel!
    @IBOutlet weak var followingDescription: UILabel!
    
    
    static let cellIdentifier = "FollowingTableViewCell"
    static let cellNib = UINib(nibName: "FollowingTableViewCell", bundle: Bundle.main)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
