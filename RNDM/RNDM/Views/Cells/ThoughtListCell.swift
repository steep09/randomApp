//
//  ThoughtListCell.swift
//  RNDM
//
//  Created by Stephenson Ang on 10/26/19.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit
import Firebase

class ThoughtListCell: UITableViewCell {

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var thoughtTxtLbl: UILabel!
    @IBOutlet weak var numOfLikesLbl: UILabel!
    
    
    func configureCell(thought: Thought) {
        
        self.userNameLbl.text = thought.userName
//        self.timeStampLbl.text = thought.timeStamp
        self.thoughtTxtLbl.text = thought.thoughtTxt
        self.numOfLikesLbl.text = String(thought.numofLikes)
        
        let date = Date(timeIntervalSince1970: TimeInterval(thought.timeStamp.seconds))
        print("\(thought.timeStamp.seconds) \(date)")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: date)
        self.timeStampLbl.text = timestamp
        
    }
}
