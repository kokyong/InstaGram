//
//  publishPostViewController.swift
//  Insta.Gram
//
//  Created by Seow Yung Hoe on 13/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import FirebaseStorage



class publishPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var previewImage: UIImageView!
    
    @IBOutlet weak var writeCaption: UITextView!
    
    @IBOutlet weak var postBarButtonPressed: UIBarButtonItem!{
        didSet{
            
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }





    
    
    
    
    //Upload image to Firebase
    func uploadImage(image :UIImage) {
        
        let storageRef = FIRStorage.storage().reference()
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let timeStamp = Date.timeIntervalSinceReferenceDate
        let a = ("\(timeStamp)")
        let dataBaseChild = a.replacingOccurrences(of: ".", with: "")
        
        //create Data
        guard let imageData = UIImageJPEGRepresentation(image, 0.8) else {return}
        storageRef.child("\(dataBaseChild)").put(imageData, metadata: metadata) {
            (meta,error) in
            
            self.dismiss(animated: true, completion: nil)
            
            if error != nil {
                return
            }
            
            if let downloadURL = meta?.downloadURL()?.absoluteString {
                //                self.sendImageMessageWithUrl(imageUrl1: downloadURL)
                //save to database
            }else{
                //display error
                
            }
        }
        
    }


}
