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

class MainProfileViewController: UIViewController {

    //IBOutlet
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var postsCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
}
