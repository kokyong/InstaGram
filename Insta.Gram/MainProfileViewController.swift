//
//  MainProfileViewController.swift
//  Insta.Gram
//
//  Created by Kok Yong on 13/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import Firebase

class MainProfileViewController: UIViewController {
    
    var userDetails : [UserDetail] = []
    var postDetails : [PostDetail] = []
    var displayUserName = String()
    var displayUserProfile = String()
    var displayUserDescription = String()
    
    
    let ref = FIRDatabase.database().reference()
    
    //IBOutlet
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    
    @IBOutlet weak var postColectionView: UICollectionView!
    
    @IBOutlet weak var postsCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    
    
    @IBOutlet weak var followingCount: UILabel!
    
    @IBOutlet weak var editProfileButton: UIButton!{
        
        didSet{
            editProfileButton.addTarget(self, action: #selector(nextViewController), for: .touchUpInside)
            
        }
        
    }
    
    func nextViewController() {
        
        //push to edit profile VC
        
        let storyboard = UIStoryboard(name: "MainProfile", bundle: Bundle.main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController else {return}
        
        navigationController?.pushViewController(controller, animated: true)
        
        
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    func goToFollower() {
        
        let storyboard = UIStoryboard(name: "MainProfile", bundle: Bundle.main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "FollowerViewController") as? FollowerViewController else {return}
        
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference()
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            let value = snapshot.value as? NSDictionary
            
            let displayName = value?["username"] as? String
            let displayDescription = value?["description"] as? String
            let displayPicture = value?["profileURL"] as? String
            
            self.displayUserProfile = displayPicture!
            self.displayUserName = displayName!
            self.displayUserDescription = displayDescription!
            
            
            self.descriptionLabel.text = self.displayUserDescription
            self.navigationItem.title = self.displayUserName
            //self.profilePicture.image = self.displayUserProfile
            // dump(displayPicture)
            //dump(displayName)
            
            if let url = NSURL(string: self.displayUserProfile) {
                if let data = NSData(contentsOf: url as URL) {
                    self.profilePicture.image = UIImage(data: data as Data)
                }
            }

        
        })
        
    }
}

//extension MainProfileViewController : UICollectionViewDataSource{
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return postDetails.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let postDetail = postDetails[indexPath.row]
//
//        guard let postCell = postColectionView.dequeueReusableCell(withIdentifier: postColectionView, for: indexPath) as? postColectionView
//
//            else {
//                return UICollectionViewCell()
//        }
//
//
//        if let url = postDetail.postPicture {
//
//            if let data = try? Data(contentsOf: url) {
//                postCell.followerPicture?.image = UIImage(data: data)
//            }
//        }
//
//        return postCell
//
//
//    }
//
//
//}





