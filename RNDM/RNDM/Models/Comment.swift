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
    private(set) var documentId: String!
    private(set) var userId: String!
    
    init(userName: String, timeStamp: Timestamp, commentsTxt: String, documentId: String, userId: String) {
        self.userName = userName
        self.timeStamp = timeStamp
        self.commentsTxt = commentsTxt
        self.documentId = documentId
        self.userId = userId
    }
    
    class func parseData(snapShot: QuerySnapshot?) -> [Comment] {
        var comments = [Comment]()
        
        guard let snap = snapShot else { return comments }
        
        for document in snap.documents {
            let data = document.data()
            let username = data["userName"] as? String ?? "Anonymous"
            let timestamp = data["timeStamp"] as? Timestamp ?? Timestamp()
            let commentTxt = data["commentTxt"] as? String ?? ""
            let documentid = document.documentID
            let userid = data["userId"] as? String ?? ""
        
            let newComment = Comment(userName: username, timeStamp: timestamp, commentsTxt: commentTxt, documentId: documentid, userId: userid)
            comments.append(newComment)
        }
        
        return comments
    }
}
