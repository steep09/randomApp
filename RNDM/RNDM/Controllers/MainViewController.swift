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
    private var thoughtsListener: ListenerRegistration!
    private var selectedCategory = "funny"
    
    private var handle: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        
        thoughtsCollectionRef = Firestore.firestore().collection(thought_ref)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            print("USER: \(user?.email)")
            if user == nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                self.present(loginVC, animated: false, completion: nil)
            } else {
                super.viewWillAppear(animated)
                self.setListener()
            }
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if thoughtsListener != nil {
            thoughtsListener.remove()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toComments", sender: thoughtList[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toComments" {
            if let destinationVC = segue.destination as? CommentsViewController {
                if let thought = sender as? Thought {
                    destinationVC.thought = thought
                }
            }
        }
    }
    
}
extension MainViewController {
    
    func setListener() {
        
        if selectedCategory == "popular" {
            thoughtsListener = thoughtsCollectionRef
                .order(by: numOfLikes, descending: true)
                .addSnapshotListener { (snapshot, error) in
            if let err = error {
                print("Error fetching docs: \(err)")
            } else {
                self.thoughtList.removeAll()
                self.thoughtList = Thought.parseData(snapShot: snapshot)
                self.tableView.reloadData()
                }
            }
        } else {
            thoughtsListener = thoughtsCollectionRef
                .whereField(category, isEqualTo: selectedCategory).order(by: timeStamp, descending: true)
                .addSnapshotListener { (snapshot, error) in
            if let err = error {
                print("Error fetching docs: \(err)")
            } else {
                self.thoughtList.removeAll()
                self.thoughtList = Thought.parseData(snapShot: snapshot)
                self.tableView.reloadData()
                }
            }
        }
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
        
        if thoughtsListener != nil {
            thoughtsListener.remove()
        }
        setListener()
    }
    
    @IBAction func logOutBtnWasPressed(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
}
