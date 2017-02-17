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
    var postImage : [PostPictureCollectionViewCell] = []
    var displayUserName = String()
    var displayUserProfile = String()
    var displayUserDescription = String()
    var displayPostImage = String()
    
    
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
    
    func goToFollowing() {
        
        let storyboard = UIStoryboard(name: "MainProfile", bundle: Bundle.main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "FollowingViewController") as? FollowingViewController else {return}
        
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    
    
    @IBOutlet weak var followersButton: UIBarButtonItem!{
        
        
        didSet{
            
            followersButton.action = #selector(goToFollower)
            followersButton.target = self
            
            print("Go")
            
        }
    }
    
    
    @IBOutlet weak var followingButton: UIBarButtonItem!{
        
        didSet{
            
            followingButton.action = #selector(goToFollowing)
            followingButton.target = self
            
            
            
        }
    }
    
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        postColectionView.dataSource = self
        //postColectionView.delegate = self
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference()
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            let value = snapshot.value as? NSDictionary
            
            let displayName = value?["username"] as? String
            let displayDescription = value?["description"] as? String
            let displayPicture = value?["profileURL"] as? String
            //let pathToImage = value?["pathToImage"] as? String
            
            
            
            self.displayUserProfile = displayPicture!
            self.displayUserName = displayName!
            self.displayUserDescription = displayDescription!
            //self.displayPostImage = pathToImage!
            
            
            self.descriptionLabel.text = self.displayUserDescription
            self.navigationItem.title = self.displayUserName
            
            
            if let url = NSURL(string: self.displayUserProfile) {
                if let data = NSData(contentsOf: url as URL) {
                    self.profilePicture.image = UIImage(data: data as Data)
                }
            }
            
            
        })
        
    }
}






