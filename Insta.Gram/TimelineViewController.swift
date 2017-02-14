//
//  TimelineViewController.swift
//  Insta.Gram
//
//  Created by Seow Yung Hoe on 13/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class TimelineViewController: UIViewController {

    
    
    //Outlets
    @IBOutlet weak var timelineTableView: UITableView! {
        didSet {
            
        timelineTableView.dataSource = self
            
        }
    }
    
    @IBOutlet weak var addPostButtonPressed: UIToolbar!{
        
        didSet{
            
            
        }
    }
    
    var posts = [//Class from ky
                                ]
    var following = [String]()
    var dbRef : FIRDatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        dbRef = FIRDatabase.database().reference()
        
        dbRef.child("").queryOrderedByKey().observeSingleEvent(of: .value, with: { snapshot in
         
            let users = snapshot.value as! [String : AnyObject]
        
            for (_,value) in users {
                if let uid = value["uid"] as? String {
                    if uid == FIRAuth.auth()?.currentUser?.uid {
                        if let followingUsers = value ["following"] as? [String : String] {
                            for (_,user) in followingUsers {
                            self.following.append(user)
                                
                          }
                        }
                        self.following.append(FIRAuth.auth()!.currentUser!.uid)
                        
                        self.dbRef.child("").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snap) in
                            
                            let postsSnap = snap.value as! [String : AnyObject]
                            
                            for (_,post) in postsSnap {
                                if let userID = value["userID"] as? String {
                                    for each in self.following {
                                        if each == userID {
                                            
                                        }
                                    }
                                }
                            }
                        })
                    }
                }
            }
        })

    
    }
    
    func fetchPosts(){
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func displayImagePicker(){
        
        let pickerController = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            pickerController.sourceType = .photoLibrary
            
        }
        
        pickerController.delegate = self
        
        present(pickerController, animated: true, completion: nil)
        

 }
}




//EXTENSION
extension TimelineViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = timelineTableView.dequeueReusableCell(withIdentifier: TimelineTableViewCell.cellIdentifier, for: indexPath) as? TimelineTableViewCell
            else {
                return UITableViewCell()
        }
        
        return cell
    }
    
}


extension TimelineViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            
            uploadImage(image: image)
        }
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
