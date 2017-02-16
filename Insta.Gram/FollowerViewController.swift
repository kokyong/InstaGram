//
//  FollowerViewController.swift
//  Insta.Gram
//
//  Created by Kok Yong on 14/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class FollowerViewController: UIViewController {
    
    var followerDetails : [UserDetail] = []
    
    @IBOutlet weak var followerTableView: UITableView!{
        
        didSet{
            
            followerTableView.dataSource = self
            
        }
        
    }
    
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        followerTableView.register(FollowerTableViewCell.cellNib, forCellReuseIdentifier: FollowerTableViewCell.cellIdentifier)
        
        followerTableView.estimatedRowHeight = 80
        followerTableView.rowHeight = UITableViewAutomaticDimension
        
        
        self.followerTableView.backgroundColor = UIColor.black
    }
}


extension FollowerViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return followerDetails.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let followerDetail = followerDetails[indexPath.row]
        
        guard let followerCell = followerTableView.dequeueReusableCell(withIdentifier: FollowerTableViewCell.cellIdentifier, for: indexPath) as? FollowerTableViewCell
            
            else {
                return UITableViewCell()
        }
        
        
        if let url = followerDetail.profilePicture {
            
            if let data = try? Data(contentsOf: url) {
                followerCell.followerPicture?.image = UIImage(data: data)
            }
        }
        
        
        followerCell.followerUsername.text = followerDetail.userName
        followerCell.followerDescription.text = followerDetail.userDescription
        
        
        return followerCell
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.black
    }
    
}



