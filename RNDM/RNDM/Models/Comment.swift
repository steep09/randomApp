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
}
