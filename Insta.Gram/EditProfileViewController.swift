//
//  EditProfileViewController.swift
//  Insta.Gram
//
//  Created by Kok Yong on 13/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import Firebase

class EditProfileViewController: UIViewController {
    
    
    
    
    //IBOutlet
    
    @IBOutlet weak var profilePictureEdit: UIImageView!
    
    @IBOutlet weak var changeProfilePictureButton: UIButton!{
        
        didSet{
            changeProfilePictureButton.addTarget(self, action: #selector(displayImagePicker), for: .touchUpInside)
            
        }
        
        
    }
    
    func displayImagePicker() {
        
        let pickerImageController = UIImagePickerController()
        
        //to check does the device have the source type
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            pickerImageController.sourceType = .photoLibrary
            
            
        }
        
        pickerImageController.delegate = self
        pickerImageController.allowsEditing = true
        
        present(pickerImageController, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    
    @IBOutlet weak var confirmEditButton: UIButton!{
        
        
        didSet{
            
            confirmEditButton.addTarget(self, action: #selector(confirmEdit), for: .touchUpInside)
            
        }
    }
    
    func confirmEdit() {
        
        guard let username = usernameTF.text, let email = emailTF.text, let description = descriptionTF.text else {return}
        
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference()
        let value = ["email": email, "username": username, "description": description] as [String : Any]
        
        ref.child("users").child(uid!).updateChildValues(value, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                
                print("err")
                
                return
                
                
            }
        })
        
        
        let storyboard = UIStoryboard(name: "MainProfile", bundle: Bundle.main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MainProfileViewController") as? MainProfileViewController else {return}
        
        
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
