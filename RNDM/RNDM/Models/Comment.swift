//
//  Comment.swift
//  RNDM
//
//  Created by Stephenson Ang on 10/29/19.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import Foundation
import Firebase

class Comment {
    
    private(set) var userName: String!
    private(set) var timeStamp: Timestamp!
    private(set) var commentsTxt: String!
    
    init(userName: String, timeStamp: Timestamp, commentsTxt: String) {
        self.userName = userName
        self.timeStamp = timeStamp
        self.commentsTxt = commentsTxt
    }
    
    class func parseData(snapShot: QuerySnapshot?) -> [Comment] {
        var comments = [Comment]()
        
        guard let snap = snapShot else { return comments }
        
        for document in snap.documents {
            let data = document.data()
            let username = data["userName"] as? String ?? "Anonymous"
            let timestamp = data["timeStamp"] as? Timestamp ?? Timestamp()
            let commentTxt = data["commentTxt"] as? String ?? ""
        
            let newComment = Comment(userName: username, timeStamp: timestamp, commentsTxt: commentTxt)
            comments.append(newComment)
        }
        
        return comments
    }
}
