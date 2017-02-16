//
//  FollowingViewController.swift
//  Insta.Gram
//
//  Created by Kok Yong on 14/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import Firebase

class FollowingViewController: UIViewController {
    
    var followingDetails : [UserDetail] = []
    
    @IBOutlet weak var followingTableView: UITableView!{
        
        didSet{
            
            followingTableView.dataSource = self
            
        }
        
    }
    
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        followingTableView.register(FollowerTableViewCell.cellNib, forCellReuseIdentifier: FollowerTableViewCell.cellIdentifier)
        
        followingTableView.estimatedRowHeight = 80
        followingTableView.rowHeight = UITableViewAutomaticDimension
        
        
        self.followingTableView.backgroundColor = UIColor.black
    }
}


extension FollowingViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return followingDetails.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let followingDetail = followingDetails[indexPath.row]
        
        guard let followingCell = followingTableView.dequeueReusableCell(withIdentifier: FollowingTableViewCell.cellIdentifier, for: indexPath) as? FollowingTableViewCell
            
            else {
                return UITableViewCell()
        }
        
        
        if let url = followingDetail.profilePicture {
            
            if let data = try? Data(contentsOf: url) {
                followingCell.followingPicture?.image = UIImage(data: data)
            }
        }
        
        
        followingCell.followingUsername.text = followingDetail.userName
        followingCell.followingDescription.text = followingDetail.userDescription
        
        
        return followingCell
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.black
    }
    
}

