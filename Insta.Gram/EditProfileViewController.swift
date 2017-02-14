//
//  EditProfileViewController.swift
//  Insta.Gram
//
//  Created by Kok Yong on 13/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    

    
    //IBOutlet
    
    @IBOutlet weak var profilePictureEdit: UIImageView!
    
    @IBOutlet weak var changeProfilePictureButton: UIButton!{
        
        didSet{
            changeProfilePictureButton.addTarget(self, action: #selector(displayImagePicker), for: .touchUpInside)
            
        }
        
        
    }
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    
    @IBOutlet weak var confirmEditButton: UIButton!{
        
        
        didSet{
            
            confirmEditButton.addTarget(self, action: #selector(confirmEdit), for: .touchUpInside)
            
        }
    }
    
    func confirmEdit() {
        
        
        
    }
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func displayImagePicker() {
        
        
        
    }
    
}
