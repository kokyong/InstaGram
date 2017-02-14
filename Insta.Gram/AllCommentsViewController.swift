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

class AllCommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //Variables
    var currentComments : [Comments] = []
    var dbRef : FIRDatabaseReference!


    
    //Outlets
    @IBOutlet weak var allCommentsTableView: UITableView!
    
    @IBOutlet weak var commentsTextField: UITextField!
    
    @IBOutlet weak var sendButtonPressed: UIButton!{
        didSet {
            
            
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allCommentsTableView.dataSource = self
        allCommentsTableView.delegate = self
        
        //Register CommentsCellXib to AllCommentsTableView
        allCommentsTableView.register(CommentsTableViewCell.cellNib, forCellReuseIdentifier: CommentsTableViewCell.cellIdentifier)

        dbRef = FIRDatabase.database().reference()

        observeComments()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentComments.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let comment = currentComments[indexPath.row]
        
        guard let textCell = tableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.cellIdentifier, for: indexPath) as? CommentsTableViewCell else {
            return UITableViewCell()
        }
    
        
        
        textCell.usernameLabel.text = comment.senderName
        textCell.displayPictureImageView.image = comment.senderDisplayPicture
        textCell.commentsLabel.text = comment.text
        textCell.timestampLabel.text = comment.timeAgo()
        
        
        return textCell    }
    
    //CurrentChannel Problem
    func observeComments(){
        guard
            let channleId = currentChannel?.id
            else { return }
        
        dbRef.child("channels").child(channleId).child("chats").observe(.childAdded, with: {(snapshot) in
            
            
            //Get the chat and append chat
            guard let value = snapshot.value as? [String: Any]
                else {return}
            let newChat = Chat(withDictionary: value)
            self.appendComments(newChat)
            
            
            
            print(snapshot)
        })
    }
    
    
    func sendComments(){
        //write to firebase
        
        guard let text = commentsTextField.text else {return}
        
        if text == "" {
            print ("text cannot be empty")
            
            return
        }
        
        
        func appendComments(_ chat: Comments){
            currentComments.append(chat)
            allCommentsTableView.reloadData()
            
            
            
        }
        
        //Blocker 1
        guard
            let channleId = currentChannel?.id ,
            let chatIndex = currentChannel?.chats.count
            else { return }
        
        let timestamp = Date.timeIntervalSinceReferenceDate
        //        let userEmail = currentUserChatID
        let currentUserEmail = FIRAuth.auth()?.currentUser?.email
        
        
        
        
    
        
        let chatDict: [String : Any] = ["senderId": "sender ID", "senderName": currentUserEmail, "text": text, "timeStamp": timestamp]
        
        
        //write dictionatry to firebase
        dbRef.child("channels").child(channleId).child("chats").child(String(chatIndex)).setValue(chatDict)
        
        commentsTextField.text = ""
        
        allCommentsTableView.reloadData()
        
    }
    
    
}
