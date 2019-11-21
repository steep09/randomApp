//
//  CommentsCell.swift
//  RNDM
//
//  Created by Stephenson Ang on 10/29/19.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit
import Firebase

protocol CommentDelegate {
    func commentOptionsTapped(comment: Comment)
}

class CommentsCell: UITableViewCell {

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var commentBodyLbl: UILabel!
    @IBOutlet weak var optionsMenu: UIImageView!
    
    private var comment: Comment!
    private var delegate: CommentDelegate?
    
    func configureCell(comment: Comment, delegate: CommentDelegate?) {
        
        self.comment = comment
        self.delegate = delegate
        
        self.userNameLbl.text = comment.userName
        self.commentBodyLbl.text = comment.commentsTxt
        self.optionsMenu.isHidden = true
        
        let date = Date(timeIntervalSince1970: TimeInterval(comment.timeStamp.seconds))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: date)
        self.timeStampLbl.text = timestamp
        
        if comment.userId == Auth.auth().currentUser?.uid {
            self.optionsMenu.isHidden = false
            optionsMenu.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(CommentOptionsTapped))
            optionsMenu.addGestureRecognizer(tap)
        }
    }
    
    @objc func CommentOptionsTapped() {
        delegate?.commentOptionsTapped(comment: comment)
    }
}
