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
        timelineTableView.register(TimelineTableViewCell.cellNib, forCellReuseIdentifier: TimelineTableViewCell.cellIdentifier)
            
            timelineTableView.estimatedRowHeight = 80
            timelineTableView
                .rowHeight = UITableViewAutomaticDimension
            
        }
    }
    
    
    
    @IBOutlet weak var addPostButtonPressed: UIBarButtonItem!{
        
        didSet{
            
            addPostButtonPressed.action = #selector(pushToPostImage)
            
        addPostButtonPressed.target = self
            
            
//            imageButton.addTarget(self, action: #selector(displayImagePicker), for: .touchUpInside)


            
        
        }
    }
    
    // KY
    @IBOutlet weak var profileButtonPressed: UIBarButtonItem!{
        
        didSet {
            
            profileButtonPressed.action = #selector(pushToPofileController)
            
            profileButtonPressed.target = self
            
        }
        
    }
    

    
    
    //KY
    var posts: [PostDetail] = []
    var following = [String]()
    var dbRef : FIRDatabaseReference!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        fetchPost()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logoutUser))
    
}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
              navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logoutUser))
    }
    
    func pushToPofileController() {
        
        let storyboard = UIStoryboard(name: "MainProfile", bundle: Bundle.main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MainProfileViewController") as? MainProfileViewController else {return}
        
        
        navigationController?.pushViewController(controller, animated: true)
        
        
    }
    
    func logoutUser() {
        
        do {
            try FIRAuth.auth()?.signOut()
            
        }catch let logoutError {
            print(logoutError)
        }
        
//        self.dismiss(animated: true, completion: nil)
        
                            let storyboard = UIStoryboard(name: "Auth", bundle: Bundle.main)
                            guard let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {return}
        
                                self.present(controller, animated: false, completion: nil)
        
        
    }
    

    
    func pushToPostImage() {
        let storyboard = UIStoryboard(name: "NewsFeed", bundle: Bundle.main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "publishPostViewController") as? publishPostViewController else {return}
        
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func fetchPost(){
        
        dbRef = FIRDatabase.database().reference()
        
        dbRef.child("posts").observe(.value, with: { (snapshot) in

            if let snapValues = snapshot.value as? [String : Any] {
                
                var tempPost : [PostDetail] = []
                
//                var postIndex = 0
                
                for (key, value) in snapValues {
                    
                    if let postDictionary = value as? [String: Any] {
                        
                        let newPost = PostDetail(withDictionary: postDictionary)
                        
                        tempPost.append(newPost) //save it to temporary channel
                    }
                }
                self.posts = tempPost
                self.timelineTableView.reloadData()
                
            }
            
         
        })

}

}
//EXTENSION
extension TimelineViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = timelineTableView.dequeueReusableCell(withIdentifier: TimelineTableViewCell.cellIdentifier, for: indexPath) as? TimelineTableViewCell
            else {
                return UITableViewCell()
        }
        let postNumber = posts[indexPath.row]
        
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
    
}

extension UIImageView {
    
    func downloadImage(from imgURL: String!) {
        let url = URLRequest(url: URL(string: imgURL)!)
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
            
        }
        
        task.resume()
    }
}




//Mark Method 2

//    func fetchPost() {
//
//        let ref = FIRDatabase.database().reference()
//
//        dbRef.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with: { snapshot in
//
//            let users = snapshot.value as! [String : AnyObject]
//
//            for (_,value) in users {
//                if let uid = value["uid"] as? String {
//                    if uid == FIRAuth.auth()?.currentUser?.uid {
//                        if let followingUsers = value["following"] as? [String : String]{
//                            for (_,user) in followingUsers{
//                                self.following.append(user)
//                            }
//                        }
//                        self.following.append(FIRAuth.auth()!.currentUser!.uid)
//
//        ref.child("posts").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snap) in
//
//
//
//
//
//                            let postsSnap = snap.value as! [String : AnyObject]
//
//                        guard let value = snap.value as? [String: Any] else [return]
//                         let newPost = PostDetail(withDictionary: value)
//
//
//                            for (_,post) in postsSnap {
//                                if let userID = post["userID"] as? String {
//                                    for each in self.following {
//                                        if each == userID {
//
//
//                                            let posst = PostDetail()
//                                            if let username = post["username"] as? String, let likes = post["likes"] as? Int, let pathToImage = post["pathToImage"] as? String, let postID = post["postID"] as? String, let userDisplayPicture = post["userDisplayPicture"] as? String, let timestamp = post["timestamp"] as? TimeInterval, let caption = post["caption"] as? String, let captionUsername = post["username"] as? String {
//
//                                                posst.username = username
//                                                posst.likes = likes
//                                                posst.pathToImage = pathToImage
//                                                posst.postID = postID
//                                                posst.userID = userID
//                                                posst.userDisplayPicture = userDisplayPicture
//                                                posst.timestamp = timestamp
//                                                posst.caption = caption
//                                                posst.captionUsername = username
//
//
//
//
//                                                self.posts.append(posst)
//                                             }
//                                        }
//                                    }
//
//                                    self.timelineTableView.reloadData()
//                                }
//                        }
//                        })
//                    }
//                }
//            }
//
//        })
//        ref.removeAllObservers()
//    }
//
//
// }

