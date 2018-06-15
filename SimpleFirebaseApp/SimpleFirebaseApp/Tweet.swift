//
//  Tweet.swift
//  SimpleFirebaseApp
//
//  Created by Abai on 02.04.18.
//  Copyright © 2018 Abai Kalikov. All rights reserved.
//

import Foundation
import FirebaseDatabase
class Tweet{
    private var content: String?
    private var user_email: String?
    
    init(_ content: String, _ user_email: String) {
        self.content = content
        self.user_email = user_email
    }
    
    init(_ snapshot: FIRDataSnapshot) {
        let tweet = snapshot.value as! NSDictionary
        content = tweet.value(forKey: "content") as? String
        user_email = tweet.value(forKey: "user_email") as? String
    }
    var Content: String?{
        get{
            return content
        }
    }
    var User_email: String?{
        get{
            return user_email
        }
    }
    func toJSONFormat()-> Any{
        return ["content": content,
                "user_email": user_email]
    }
}
