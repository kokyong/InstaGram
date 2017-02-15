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

    @IBOutlet weak var previewImage: UIImageView!
    
    @IBOutlet weak var writeCaption: UITextView!
    
    @IBOutlet weak var galleryButtonPressed: UIButton!{
        didSet{
            galleryButtonPressed.addTarget(self, action: #selector(displayImagePicker), for: .touchUpInside)

        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.previewImage.image = image
            self.dismiss(animated: true, completion: nil)

                    }
        else{print("asdsad")}
            
            }
    

     
    
    var picker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        
        let editButtonItem = UIBarButtonItem.init(title: "Post", style: .done, target: self
            , action: #selector(postButtonPressed))
        navigationItem.rightBarButtonItem = editButtonItem
        
//        self.navigationController?.isNavigationBarHidden = true

     
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
                                "username" : FIRAuth.auth()!.currentUser?.displayName!,
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


    func displayImagePicker(){
        
        picker.isEditing = true
        picker.sourceType = .photoLibrary
        

        self.present(picker, animated: true, completion: nil)
        
        picker.delegate = self
    }
    
    
    func grabPhotos() {
        
        let imgManager = PHImageManager.default()
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        if let fetchResult : PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOption) {
            
            if fetchResult.count > 0 {
                for i in 0..<fetchResult.count{
                    
                    imgManager.requestImage(for: fetchResult.object(at: i) as! PHAsset , targetSize: .init(width: 200, height: 200), contentMode: .aspectFit, options: requestOptions, resultHandler: {
                        image, eror in
                        
                        self.imageArray.append(image!)
                    })
                    
                }
                
            }
            else{
                print ("No Photo Detected")
            }
            
            
        }
        
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
