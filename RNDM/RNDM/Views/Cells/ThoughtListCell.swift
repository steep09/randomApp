//
//  ThoughtListCell.swift
//  RNDM
//
//  Created by Stephenson Ang on 10/26/19.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit
import Firebase

protocol ThoughtDelegate {
    func thoughtOptionsTapped(thought: Thought)
}

class ThoughtListCell: UITableViewCell {

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var thoughtTxtLbl: UILabel!
    @IBOutlet weak var numOfLikesLbl: UILabel!
    @IBOutlet weak var numOfCommentsLbl: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet weak var commentImg: UIImageView!
    @IBOutlet weak var optionsMenu: UIImageView!
    
    private var thought: Thought!
    private var delegate: ThoughtDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeBtnTapped))
        likeImg.addGestureRecognizer(tap)
        likeImg.isUserInteractionEnabled = true
        
    }
    
    @objc func likeBtnTapped() {
        Firestore.firestore().collection(thought_ref).document(thought.documentId).updateData(["numOfLikes": thought.numofLikes + 1])
    }
    
}
extension ThoughtListCell {
    
    func configureCell(thought: Thought, delegate: ThoughtDelegate?) {
        optionsMenu.isHidden = true
        self.thought = thought
        self.delegate = delegate
        
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
        
        if thought.userId == Auth.auth().currentUser?.uid {
            optionsMenu.isHidden = false
            optionsMenu.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(thoughtOptionsTapped))
            optionsMenu.addGestureRecognizer(tap)
        }
        
    }
    
    @objc func thoughtOptionsTapped() {
        delegate?.thoughtOptionsTapped(thought: thought)
    }
    
}
