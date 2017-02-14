//
//  publishPostViewController.swift
//  Insta.Gram
//
//  Created by Seow Yung Hoe on 13/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase


class publishPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var previewImage: UIImageView!
    
    @IBOutlet weak var writeCaption: UITextView!
    
    @IBOutlet weak var galleryButtonPressed: UIButton!{
        didSet{
            galleryButtonPressed.addTarget(self, action: #selector(displayImagePicker), for: .touchUpInside)

        }
    }
    
    @IBAction func postButtonPressed(_ sender: UIBarButtonItem) {
        AppDelegate.instance().showActivityIndicator()
        
        let uid = FIRAuth.auth()!.currentUser!.uid
        let ref = FIRDatabase.database().reference()
        let storage = FIRStorage.storage().reference(forURL: "https://instagram-6de25.firebaseio.com/")
        
        let idForPost = ref.child("posts").childByAutoId().key
        let imageRef = storage.child("posts").child(uid).child("\(idForPost).jpg")
        
        let data = UIImageJPEGRepresentation(self.previewImage.image!, 0.6)
        
        let uploadTask = imageRef.put(data!, metadata: nil){(metadata, error)in
            if error != nil {
                print(error!.localizedDescription)
                AppDelegate.instance().dismissActivityIndicator()
                return
            }
            
            imageRef.downloadURL(completion: {(url, error) in
                if let url = url {
                    let feed = ["userID" : uid,
                                "pathToImage" : url.absoluteString,
                                "likes" : 0,
                                "username" : FIRAuth.auth()!.currentUser?.displayName!,
                    "postID" : idForPost] as [String : Any]
                    
                    let postFeed = ["\(idForPost)" : feed]
                    
                    ref.child("posts").updateChildValues(postFeed)
                    AppDelegate.instance().dismissActivityIndicator()
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
        
        uploadTask.resume()
    }
    
     
    
    var picker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        
        // Do any additional setup after loading the view.
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.previewImage.image = image
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }




    func displayImagePicker(){
        
        picker.isEditing = true
        picker.sourceType = .photoLibrary
        

        self.present(picker, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    //Upload image to Firebase
//    func uploadImage(image :UIImage) {
//        
//        let storageRef = FIRStorage.storage().reference()
//        let metadata = FIRStorageMetadata()
//        metadata.contentType = "image/jpeg"
//        
//        let timeStamp = Date.timeIntervalSinceReferenceDate
//        let a = ("\(timeStamp)")
//        let dataBaseChild = a.replacingOccurrences(of: ".", with: "")
//        
//        //create Data
//        guard let imageData = UIImageJPEGRepresentation(image, 0.8) else {return}
//        storageRef.child("\(dataBaseChild)").put(imageData, metadata: metadata) {
//            (meta,error) in
//            
//            self.dismiss(animated: true, completion: nil)
//            
//            if error != nil {
//                return
//            }
//            
//            if let downloadURL = meta?.downloadURL()?.absoluteString {
//                //                self.sendImageMessageWithUrl(imageUrl1: downloadURL)
//                //save to database
//            }else{
//                //display error
//                
//            }
//        }
//        
//    }


}
