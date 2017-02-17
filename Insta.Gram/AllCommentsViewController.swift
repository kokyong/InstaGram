//
//  AllCommentsViewController.swift
//  Insta.Gram
//
//  Created by Seow Yung Hoe on 13/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class AllCommentsViewController: UIViewController,  UITableViewDelegate {
    
    
    //Variables
    var currentComments : [Comments] = []
    var dbRef : FIRDatabaseReference!
    var uid : String?
    var displayNameSender : String?
    var currentPost : PostDetail?
    
    //Outlets
    @IBOutlet weak var allCommentsTableView: UITableView!{
        didSet{
            allCommentsTableView.delegate = self
//            allCommentsTableView.dataSource = self
            //register custom cell
            allCommentsTableView.register(CommentsTableViewCell.cellNib, forCellReuseIdentifier: CommentsTableViewCell.cellIdentifier)
           allCommentsTableView.estimatedRowHeight = 80
            allCommentsTableView.rowHeight = UITableViewAutomaticDimension
        }
    }

    
    @IBOutlet weak var commentsTextField: UITextField!
    
    @IBOutlet weak var sendButtonPressed: UIButton!{
        didSet{
//            sendButtonPressed.addTarget(self, action: #selector(sendComments ), for: .touchUpInside)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = FIRDatabase.database().reference()
        
        
        uid = FIRAuth.auth()?.currentUser?.uid
        
        dbRef.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let displayName = value?["displayName"] as? String ?? ""
            
            self.displayNameSender = displayName
            dump(snapshot)
            print(displayName)
        })
    }
    func sendComments(){
        guard
            let postId = currentPost?.id
            else {return}
        
        //catching time interval
        let timestamp = Date.timeIntervalSinceReferenceDate
        let chatIndex = currentComments.count
        
        
        
        //saving time interval to database
        var chatDictionary : [String: Any] = ["senderID" : uid, "senderName" : displayNameSender, "timeStamp" : timestamp]
        
        if let text = commentsTextField.text {
            //saving msg text to database
            chatDictionary["text"] = text
        }
        
        dbRef.child("PostDetail").child(postId).child("chats").child(String(chatIndex)).setValue(chatDictionary)
        
        commentsTextField.text = ""
    }
    func observeChat(){
        guard
            let postId = currentPost?.id
            else {return}
        dbRef.child("users").child(postId).child("chats").observe(.childAdded, with: { (snapshot) in
            
            //appendChat
            guard let value = snapshot.value as? [String: Any] else {return}
            let newChat = Comments(withDictionary: value)
            self.appendChat(newChat)
        })
    }
    func appendChat(_ chat: Comments){
        currentComments.append(chat)
        allCommentsTableView.reloadData()
    }

    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
   
    


    //ChatViewController
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentComments.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let comment = currentComments[indexPath.row]
        
        guard let textCell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.cellIdentifier, for: indexPath) as? CommentsTableViewCell else {
            return UITableViewCell()
        }
    
        
        
        textCell.usernameLabel.text = comment.senderName
//        textCell.displayPictureImageView.image = comment.senderDisplayPicture
        textCell.commentsLabel.text = comment.text
        textCell.timestampLabel.text = comment.timeAgo()
        
        
        return textCell    }
    
    
}




    //CurrentChannel Problem
//    func observeComments(){
////        guard
////            let channleId = currentChannel?.id
////            else { return }
//        
////        dbRef.child("channels").child(channleId).child("chats").observe(.childAdded, with: {(snapshot) in
//        
//            
//            //Get the chat and append chat
//            guard let value = snapshot.value as? [String: Any]
//                else {return}
//            let newChat = Chat(withDictionary: value)
//            self.appendComments(newChat)
//            
//            
//            
//            print(snapshot)
//        })
//    }
    
    
    
       
            
        
        
        //Blocker 1
//        guard
////            let channleId = currentChannel?.id ,
////            let chatIndex = currentChannel?.chats.count
//            else { return }
        
    
        //        let userEmail = currentUserChatID
    
        
        
        
    
        
    
        
        
        //write dictionatry to firebase
//        dbRef.child("channels").child(channleId).child("chats").child(String(chatIndex)).setValue(chatDict)
        

    
    

