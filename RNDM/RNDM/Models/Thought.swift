//
//  Thought.swift
//  RNDM
//
//  Created by Stephenson Ang on 10/26/19.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import Foundation
import Firebase

class Thought {
    
    private(set) var userName: String!
    private(set) var numofComments: Int!
    private(set) var numofLikes: Int!
    private(set) var thoughtTxt: String!
    private(set) var timeStamp: Timestamp!
    private(set) var documentId: String!
    private(set) var userId: String!
    
    init(userName: String, numofComments: Int, numofLikes: Int, thoughtTxt: String, timeStamp: Timestamp, documentId: String, userId: String) {
        
        self.userName = userName
        self.numofComments = numofComments
        self.numofLikes = numofLikes
        self.thoughtTxt = thoughtTxt
        self.timeStamp = timeStamp
        self.documentId = documentId
        self.userId = userId
    }
    
    class func parseData(snapShot: QuerySnapshot?) -> [Thought] {
        var thoughts = [Thought]()
        
        guard let snap = snapShot else { return thoughts }
        
        for document in snap.documents {
            let data = document.data()
            let username = data["userName"] as? String ?? "Anonymous"
            let timestamp = data["timeStamp"] as? Timestamp ?? Timestamp()
            let thoughttxt = data["thoughtTxt"] as? String ?? ""
            let numlikes = data["numOfLikes"] as? Int ?? 0
            let numcomments = data["numOfComments"] as? Int ?? 0
            let documentid = document.documentID
            let userid = data["userId"] as? String ?? ""
        
            let newThought = Thought(userName: username, numofComments: numcomments, numofLikes: numlikes, thoughtTxt: thoughttxt, timeStamp: timestamp, documentId: documentid, userId: userid)
            thoughts.append(newThought)
        }
        
        return thoughts
    }
    
}
