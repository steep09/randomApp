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
    
    init(userName: String, numofComments: Int, numofLikes: Int, thoughtTxt: String, timeStamp: Timestamp, documentId:String) {
        
        self.userName = userName
        self.numofComments = numofComments
        self.numofLikes = numofLikes
        self.thoughtTxt = thoughtTxt
        self.timeStamp = timeStamp
        self.documentId = documentId
    }
    
}
