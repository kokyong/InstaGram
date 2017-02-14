//
//  Comments.swift
//  Insta.Gram
//
//  Created by Seow Yung Hoe on 14/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import Foundation

class Comments {
    var senderID: String?
    var senderName: String?
    var senderDisplayPicture: URL?
    var text: String?
    var timestamp : TimeInterval?

    
    
    init(withDictionary dictionary: [String:Any])
    {
        senderID = dictionary["senderId"] as? String
        senderName = dictionary["senderName"] as? String
        text = dictionary["text"] as? String
        timestamp = dictionary["timeStamp"] as? TimeInterval
        
        if let imageURL = dictionary["senderDisplayPicture"] as? String {
            senderDisplayPicture = URL(string: imageURL)
            
        }
        
    }
    
    
    func timeAgo() -> String {
        
        guard let timestamp = timestamp
            else{
                return ("Time stamp error")
        }
        
        let sentTime = Date(timeIntervalSinceReferenceDate: timestamp)
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "d MMM yyyy HH:mm:ss"
        
        dateformatter.string(from: sentTime)
        return dateformatter.string(from: sentTime)
    }

}
