//
//  ThoughtListCell.swift
//  RNDM
//
//  Created by Stephenson Ang on 10/26/19.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit

class ThoughtListCell: UITableViewCell {

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var thoughtTxtLbl: UILabel!
    @IBOutlet weak var numOfLikesLbl: UILabel!
    
    
    func configureCell(thought: Thought) {
//        
//        self.userNameLbl.text = thought.userName
//        self.timeStampLbl.text = thought.timeStamp
    }
}
