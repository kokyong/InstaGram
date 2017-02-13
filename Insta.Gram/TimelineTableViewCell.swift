//
//  TimelineTableViewCell.swift
//  Insta.Gram
//
//  Created by Seow Yung Hoe on 13/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //Outlets
    @IBOutlet weak var displayPictureImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var imagePostedImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!{
        didSet {
            
        }
    }
    
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    
    @IBOutlet weak var captionUsername: UILabel!
    
    @IBOutlet weak var captionMessages: UILabel!
    
    @IBOutlet weak var viewAllCommentsButton: UIButton! {
        didSet {
            
            let storyboard = UIStoryboard(name: "NewsFeed", bundle: Bundle.main)
            guard let controller = storyboard?.instantiateViewController(withIdentifier: "AllCommentsViewController") as? AllCommentsViewController else {return}
            
            navigationController?.pushViewController(controller, animated: true)

            
        }
    }
    
    @IBOutlet weak var timelineTimestamp: UILabel!
    
    
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
