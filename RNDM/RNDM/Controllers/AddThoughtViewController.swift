//
//  AddThoughtViewController.swift
//  RNDM
//
//  Created by Stephenson Ang on 10/24/19.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit
import Firebase

class AddThoughtViewController: UIViewController {
    
    @IBOutlet private weak var categorySegment: UISegmentedControl!
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var ThoughtDescription: UITextView!
    @IBOutlet private weak var postBtn: UIButton!
    
    private var selectedCategory = "funny"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ThoughtDescription.delegate = self
        
        userNameTextField.layer.cornerRadius = 10.0
        ThoughtDescription.layer.cornerRadius = 10.0
        postBtn.layer.cornerRadius = 10.0
        
        ThoughtDescription.text = "My Random Thought here..."
    }
    
    @IBAction func categoryChanged(_ sender: Any) {
        switch categorySegment.selectedSegmentIndex {
        case 0:
            self.selectedCategory = "funny"
            print("\(self.selectedCategory)")
        case 1:
            self.selectedCategory = "serious"
            print("\(self.selectedCategory)")
        case 2:
            self.selectedCategory = "crazy"
            print("\(self.selectedCategory)")
        case 3:
            selectedCategory = "popular"
            print("\(self.selectedCategory)")
        default:
           break
        }
    }
    
    @IBAction func PostBtnWasPressed(_ sender: Any) {
        
        Firestore.firestore().collection(thought_ref).addDocument(data: [
            "category": self.selectedCategory,
            "numOfComments": 0,
            "numOfLikes": 0,
            "thoughtTxt": self.ThoughtDescription.text!,
            "timeStamp": FieldValue.serverTimestamp(),
            "userName": Auth.auth().currentUser?.displayName ?? "Anonymous",
            "userId": Auth.auth().currentUser?.uid ?? "",
            "likedBy": []
        ]) { (error) in
            if error != nil {
                print("ERROR ADDING DOCUMENT!")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
}

extension AddThoughtViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        ThoughtDescription.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if ThoughtDescription.text == "" {
            ThoughtDescription.text = "My Random Thought here..."
        }
    }
}
