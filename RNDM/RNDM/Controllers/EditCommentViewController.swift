//
//  EditCommentViewController.swift
//  RNDM
//
//  Created by Stephenson Ang on 11/23/19.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit
import Firebase

class EditCommentViewController: UIViewController {
    
    @IBOutlet weak var editCommentTextView: UITextView!
    @IBOutlet weak var doneEditCommentBtn: UIButton!
    
    var commentData: (comment: Comment, thought: Thought)!

    override func viewDidLoad() {
        super.viewDidLoad()
        editCommentTextView.layer.cornerRadius = 10.0
        doneEditCommentBtn.layer.cornerRadius = 10.0
        editCommentTextView.text = commentData.comment.commentsTxt
    }
    
    
    @IBAction func doneEditCommentBtnWasPressed(_ sender: Any) {
        Firestore.firestore().collection(thought_ref).document(commentData.thought.documentId).collection(comments_ref).document(commentData.comment.documentId)
            .updateData([COMMENTTXT : editCommentTextView.text!]) { (error) in
                if let error = error {
                    debugPrint("error updating comment: \(error.localizedDescription)")
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
        }
    }
}
