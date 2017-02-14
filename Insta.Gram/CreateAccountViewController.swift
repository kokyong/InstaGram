//
//  CreateAccountViewController.swift
//  Insta.Gram
//
//  Created by Seow Yung Hoe on 10/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    let picker = UIImagePickerController()
    //Outlet
    @IBOutlet weak var userImageView: UIImageView!
  
    @IBOutlet weak var userUsenameField: UITextField!
    @IBOutlet weak var userEmailField: UITextField!
    
    @IBOutlet weak var userPasswordField: UITextField!
    
    //Action
   
    
    @IBAction func userImagePressed(_ sender: UIButton) {
    }
    @IBAction func userSignUpPress(_ sender: UIButton) {
        
        
        guard let username = userUsenameField.text, let email = userEmailField.text, let password = userPasswordField.text else {return
    }
        
        
        FIRAuth.auth()?.createUser(withEmail: userEmailField.text!, password: userPasswordField.text!,  completion: { (user,error) in
            
            if error != nil{
                print (error! as NSError)
                return
            }
            
            self.handleUser(user: user!)
    })
    }
    func handleUser(user: FIRUser) {
    print("User found :\(user.uid)")
    }
        
}








