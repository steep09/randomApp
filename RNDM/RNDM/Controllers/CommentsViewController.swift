//
//  CommentsViewController.swift
//  RNDM
//
//  Created by Stephenson Ang on 10/29/19.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit
import Firebase

class CommentsViewController: UIViewController {
    
    @IBOutlet var keyboardView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCommentTxtField: UITextField!
    
    var thought: Thought!
    private var commentList = [Comment]()
    var thoughtRef: DocumentReference!
    let firestore = Firestore.firestore()
    var username: String!
    private var commentsListener: ListenerRegistration!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        thoughtRef = firestore.collection(thought_ref).document(thought.documentId)
        if let name = Auth.auth().currentUser?.displayName {
            print("CURRENT USERNAME: \(name)")
            self.username = name
        } else {
            print("NO USERNAME")
        }
        self.view.bindToKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        commentsListener = firestore.collection(thought_ref)
            .document(self.thought.documentId)
            .collection("comments").order(by: TIMESTAMP, descending: false)
            .addSnapshotListener({ (snapshot, error) in
            
                guard let snapshot = snapshot else {
                    debugPrint("ERROR FETCHING COMMENTS: \(error.debugDescription)")
                    return
                }
                
                self.commentList.removeAll()
                self.commentList = Comment.parseData(snapShot: snapshot)
                self.tableView.reloadData()
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        commentsListener.remove()
    }

    @IBAction func addCommentBtnWasPressed(_ sender: Any) {
        guard let commentTxt = addCommentTxtField.text else { return }
        
        firestore.runTransaction({ (transaction, errorPointer) -> Any? in
            
            let thoughtDocument: DocumentSnapshot
            
            do {
                try thoughtDocument = transaction.getDocument(self.firestore.collection(thought_ref)
                    .document(self.thought.documentId))
            } catch let error as NSError {
                debugPrint("Fetch error: \(error.localizedDescription)")
                return nil
            }
            
            guard let oldNumComments = thoughtDocument.data()?[NUMOFCOMMENTS] as? Int else { return nil }
            
            transaction.updateData([NUMOFCOMMENTS: oldNumComments + 1], forDocument: self.thoughtRef)
            
            let newCommentRef = self.firestore.collection(thought_ref).document(self.thought.documentId).collection(comments_ref).document()
            
            transaction.setData([
                "commentTxt": commentTxt,
                TIMESTAMP: FieldValue.serverTimestamp(),
                USERNAME: self.username ?? "ANONYMOUS",
                "userId": Auth.auth().currentUser?.uid ?? ""
            ], forDocument: newCommentRef)
            
            return nil
        }) { (object, error) in
            if let error = error {
                debugPrint("Transaction error: \(error.localizedDescription)")
            } else {
                self.addCommentTxtField.text = ""
            }
        }
        self.addCommentTxtField.resignFirstResponder()
    }
    
}
extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as? CommentsCell
            else { return UITableViewCell() }
        
        cell.configureCell(comment: commentList[indexPath.row])
        return cell
    }
    
}
