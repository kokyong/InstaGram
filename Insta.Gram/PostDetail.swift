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
    
    var timeStamp : TimeInterval?
    var comment : String?
    var likeCount : String?
    var caption : String?
    var postPicture : URL?

    init(withDictionary dictionary: [String:Any]) {
        
        comment = dictionary["comment"] as? String
        likeCount = dictionary["likeCount"] as? String
        caption = dictionary["caption"] as? String
        timeStamp = dictionary["timeStamp"] as? TimeInterval
        
        if let postPictureURL = dictionary["postPicture"] as? String{
            
            postPicture = URL(string: postPictureURL)
            
        }
    }
    
    func timeAgo() -> String {
        
        guard let timeStamp = timeStamp
            else {
                
                return("Time stamp format error")
        }
        
        let sentTime = Date(timeIntervalSinceReferenceDate: timeStamp)
        let dataformatter = DateFormatter()
        dataformatter.dateFormat = "d / MM / yyyy (HH:mm:ss)"
        
        dataformatter.string(from: sentTime)
        return dataformatter.string(from: sentTime)
        
    }
    
    
}
