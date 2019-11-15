//
//  CommentsCell.swift
//  RNDM
//
//  Created by Stephenson Ang on 10/29/19.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit

class CommentsCell: UITableViewCell {

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var commentBodyLbl: UILabel!
    @IBOutlet weak var optionsMenu: UIImageView!
    
    func configureCell(comment: Comment) {
        self.userNameLbl.text = comment.userName
        self.commentBodyLbl.text = comment.commentsTxt
        
        let date = Date(timeIntervalSince1970: TimeInterval(comment.timeStamp.seconds))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: date)
        self.timeStampLbl.text = timestamp
    }
}
