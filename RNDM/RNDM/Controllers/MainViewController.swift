//
//  ViewController.swift
//  RNDM
//
//  Created by Stephenson Ang on 10/24/19.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit
import Firebase

enum ThoughtCategory: String {
    case serious = "serious"
    case funny = "funny"
    case crazy = "crazy"
    case popular = "popular"
}

class MainViewController: UIViewController {
    
    @IBOutlet private weak var categorySegment: UISegmentedControl!
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var thoughtList = [Thought]()
    private var thoughtsCollectionRef: CollectionReference!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        
        thoughtsCollectionRef = Firestore.firestore().collection(thought_ref)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        thoughtsCollectionRef.getDocuments { (snapshot, error) in
            if let err = error {
                print("Error fetching docs: \(err)")
            } else {
                for document in (snapshot?.documents)! {
                    let data = document.data()
                    let username = data[userName] as? String ?? "Anonymous"
                    let timestamp = data[timeStamp] as? Date ?? Date()
                    let thoughttxt = data[thoughtTxt] as? String ?? ""
                    let numlikes = data[numOfLikes] as? Int ?? 0
                    let numcomments = data[numOfComments] as? Int ?? 0
                    let documentid = document.documentID
                    
                    let newThought = Thought(userName: username, numofComments: numcomments, numofLikes: numlikes, thoughtTxt: thoughttxt, timeStamp: timestamp, documentId: documentid)
                    self.thoughtList.append(newThought)
                }
                self.tableView.reloadData()
            }
        }
        
    }
    
    
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thoughtList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThoughtListCell", for: indexPath) as? ThoughtListCell else { return UITableViewCell() }
        
        let thought = thoughtList[indexPath.row]
        
        cell.configureCell(thought: thought)
        
        return cell
    }
    
}
