//
//  SingleViewPostViewController.swift
//  Insta.Gram
//
//  Created by Kok Yong on 17/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit

class SingleViewPostViewController: UIViewController {
    
    var singlePostDetail :[PostDetail] = []

    
    @IBOutlet weak var singlePostTableView: UITableView!{
        
        didSet{
            
            singlePostTableView.dataSource = self
        }
        
    }
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        singlePostTableView.register(TimelineTableViewCell.cellNib, forCellReuseIdentifier: TimelineTableViewCell.cellIdentifier)
        
        singlePostTableView.estimatedRowHeight = 80
        singlePostTableView.rowHeight = UITableViewAutomaticDimension
        
        
        self.singlePostTableView.backgroundColor = UIColor.black

    }

  

}

extension SingleViewPostViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return singlePostDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = singlePostTableView.dequeueReusableCell(withIdentifier: TimelineTableViewCell.cellIdentifier, for: indexPath) as? TimelineTableViewCell
            else {
                return UITableViewCell()
        }
        let postNumber = singlePostDetail[indexPath.row]
        
        if let url = postNumber.userDisplayPicture {
            
            if let data = try? Data(contentsOf: url) {
                cell.displayPictureImageView.image = UIImage(data: data)
                
                
            }
            
        }
        
        if let url = postNumber.pathToImage {
            
            if let data = try? Data(contentsOf: url) {
                cell.imagePostedImageView.image = UIImage(data: data)
                
                
            }
            
        }
        
        
        cell.userNameLabel.text = postNumber.username
        cell.likeButton.setTitle("Like", for: .normal)
        //        cell.likeButton.setImage(UIImage (named: "heart"), for: .normal)
        cell.numberOfLikesLabel.text = "\(postNumber.likes!) Likes"
        cell.captionUsername.text = postNumber.username
        cell.captionMessages.text = postNumber.caption
        cell.viewAllCommentsButton.setTitle("View All Comments", for: .normal)
        cell.timelineTimestamp.text = postNumber.timeAgo()
        
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.black
    }
    
}


