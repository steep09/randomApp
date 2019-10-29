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
    @IBOutlet weak var numOfCommentsLbl: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet weak var commentImg: UIImageView!
    
    private var thought: Thought!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeBtnTapped))
        likeImg.addGestureRecognizer(tap)
        likeImg.isUserInteractionEnabled = true
        
    }
    
    @objc func likeBtnTapped() {
        print("Like Button Tapped")
        print("\(thought.numofLikes) -- \(thought.userName) -- \(thought.documentId)")
        Firestore.firestore().collection("Thoughts").document(thought.documentId).updateData(["numOfLikes": thought.numofLikes + 1])
    }
    
}
extension ThoughtListCell {
    
    func configureCell(thought: Thought) {
        self.thought = thought
        
        self.userNameLbl.text = thought.userName
        self.thoughtTxtLbl.text = thought.thoughtTxt
        self.numOfLikesLbl.text = String(thought.numofLikes)
        self.numOfCommentsLbl.text = String(thought.numofComments)
        
        let date = Date(timeIntervalSince1970: TimeInterval(thought.timeStamp.seconds))
        print("\(thought.timeStamp.seconds) \(date)")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: date)
        self.timeStampLbl.text = timestamp
        
    }
    
}
