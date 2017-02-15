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
import Photos


class publishPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var imageArray: [UIImage] = []
    var displayNameInPost: String?
    var displayPictureInPost: String?
    var picker = UIImagePickerController()


    @IBOutlet weak var previewImage: UIImageView!
    
    @IBOutlet weak var writeCaption: UITextView!
    
    @IBOutlet weak var galleryButtonPressed: UIButton!{
        didSet{
            galleryButtonPressed.addTarget(self, action: #selector(displayImagePickerGallery), for: .touchUpInside)

        }
    }
    
    
    @IBOutlet weak var cameraButtonPressed: UIButton!{
        didSet{
            cameraButtonPressed.addTarget(self, action: #selector(displayImagePickerCamera), for: .touchUpInside)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.previewImage.image = image
            self.dismiss(animated: true, completion: nil)

                    }
        else{print("asdsad")}
            
            }
    

     
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        
        let editButtonItem = UIBarButtonItem.init(title: "Post", style: .done, target: self
            , action: #selector(postButtonPressed))
        navigationItem.rightBarButtonItem = editButtonItem
        
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            let value = snapshot.value as? NSDictionary
            let displayName = value?["username"] as? String ?? ""
            
            
            self.displayNameInPost = displayName
            dump(displayName)
            
            
                    })
        
        
        FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            let value = snapshot.value as? NSDictionary
            let displayPicture = value?["profileURL"] as? String ?? ""
            
            
            self.displayPictureInPost = displayPicture
            dump(displayPicture)
        })

     
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//        self.navigationController?.isNavigationBarHidden = true

    }


    func postButtonPressed (){
        
        AppDelegate.instance().showActivityIndicator()
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference()
        let storage = FIRStorage.storage().reference()
        let metadata = FIRStorageMetadata()
        
        
        let idForPost = ref.child("posts").childByAutoId().key
        let imageRef = storage.child("posts").child(uid!).child("\(idForPost).jpg")
        
        
        let data = UIImageJPEGRepresentation(self.previewImage.image!, 0.6)
        
        let uploadTask = imageRef.put(data!, metadata: metadata){(metadata, error)in
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
                                "username" : self.displayNameInPost,
                                "userDisplayPicture": self.displayPictureInPost  ,
                                "caption" : self.writeCaption.text,
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


    func displayImagePickerGallery(){
        
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        

        self.present(picker, animated: true, completion: nil)
        
        picker.delegate = self
    }
    
    func displayImagePickerCamera() {
        
        picker.sourceType = .camera
        self.present(picker, animated: true, completion: nil)
        picker.delegate = self
    }
    
    


}
