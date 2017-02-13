//
//  UserDetail.swift
//  Insta.Gram
//
//  Created by Kok Yong on 13/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import Foundation
import UIKit

class UserDetail {
    
    var userName : String?
    var profileImage : URL?
    var userID : String?

    init(withDictionary dictionary: [String:Any]) {
        
        userName = dictionary["userName"] as? String
        userID = dictionary["userID"] as? String
        
        
        
    }
    
}
