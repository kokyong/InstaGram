//
//  PostDetail.swift
//  Insta.Gram
//
//  Created by Kok Yong on 13/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import Foundation
import UIKit

class PostDetail {
    
    var timestamp : TimeInterval?
    var comment : String?
    var likes : Int?
    var caption : String?
    var pathToImage : URL?
    var postID: String?
    var username: String?
    var userDisplayPicture : URL?
    var userID: String?
    var id : String?



    init(withDictionary dictionary: [String:Any]) {
        
//        id = String(index)

        timestamp = dictionary["timestamp"] as? TimeInterval
        comment = dictionary["comment"] as? String
        likes = dictionary["likes"] as? Int
        caption = dictionary["caption"] as? String
        postID = dictionary["postID"] as? String
        username = dictionary["username"] as? String
        userID = dictionary["userID"] as? String
        
        if let postPictureURL = dictionary["pathToImage"] as? String{
            
            pathToImage = URL(string: postPictureURL)
            
        }
        
        
        
        if let displayPicture = dictionary["userDisplayPicture"] as? String{
            
            userDisplayPicture = URL(string: displayPicture)
        }
        
     
    }
    
    func timeAgo() -> String {
        
        guard let timestamp = timestamp
            else {
                
                return("Time stamp format error")
        }
        
        let sentTime = Date(timeIntervalSinceReferenceDate: timestamp)
        let dataformatter = DateFormatter()
        dataformatter.dateFormat = "d / MM / yyyy (HH:mm:ss)"
        
        dataformatter.string(from: sentTime)
        return dataformatter.string(from: sentTime)
        
    }
    
    
}
