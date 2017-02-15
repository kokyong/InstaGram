//
//  TimelineViewController.swift
//  Insta.Gram
//
//  Created by Seow Yung Hoe on 13/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class TimelineViewController: UIViewController {

    
    
    //Outlets
    @IBOutlet weak var timelineTableView: UITableView! {
        didSet {
            
        timelineTableView.dataSource = self
            
        }
    }
    
    @IBOutlet weak var addPostButtonPressed: UIBarButtonItem!{
        
        didSet{
            
            addPostButtonPressed.action = #selector(pushToPostImage)
            
        addPostButtonPressed.target = self
            
            
//            imageButton.addTarget(self, action: #selector(displayImagePicker), for: .touchUpInside)


            
        
        }
    }
    
    
    
    
    
    var posts : [PostDetail] = []
    var following = [String]()
    var dbRef : FIRDatabaseReference!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timelineTableView.register(TimelineTableViewCell.cellNib, forCellReuseIdentifier: TimelineTableViewCell.cellIdentifier)
        

//        dbRef = FIRDatabase.database().reference()
//        
//        dbRef.child("").queryOrderedByKey().observeSingleEvent(of: .value, with: { snapshot in
//         
//            let users = snapshot.value as! [String : AnyObject]
//        
//            for (_,value) in users {
//                if let uid = value["uid"] as? String {
//                    if uid == FIRAuth.auth()?.currentUser?.uid {
//                        if let followingUsers = value ["following"] as? [String : String] {
//                            for (_,user) in followingUsers {
//                            self.following.append(user)
//                                
//                          }
//                        }
//                        self.following.append(FIRAuth.auth()!.currentUser!.uid)
//                        
//                        self.dbRef.child("").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snap) in
//                            
//                            let postsSnap = snap.value as! [String : AnyObject]
//                            
//                            for (_,post) in postsSnap {
//                                if let userID = value["userID"] as? String {
//                                    for each in self.following {
//                                        if each == userID {
//                                            let posst = PostDetail()
//                                            if let username = post["username"] as? String, let likes = post ["likes"] as? Int,
//                                            let pathToImage = post["pathToImage"] as? String,
//                                            let postID =
//                                            
//                                        }
//                                    }
//                                }
//                            }
//                        })
//                    }
//                }
//            }
//        })
//
//    
}
//    
    
    func pushToPostImage() {
        let storyboard = UIStoryboard(name: "NewsFeed", bundle: Bundle.main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "publishPostViewController") as? publishPostViewController else {return}
        
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
 }




//EXTENSION
extension TimelineViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = timelineTableView.dequeueReusableCell(withIdentifier: TimelineTableViewCell.cellIdentifier, for: indexPath) as? TimelineTableViewCell
            else {
                return UITableViewCell()
        }
        
        return cell
    }
    
}




