//
//  PostViewController.swift
//  Techchan
//
//  Created by so1425 on 2018/09/17.
//  Copyright © 2018年 so1425. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var postTextField: UITextField!
    @IBOutlet var table: UITableView!

    var receiveTextField: String!
    var dbRef: DatabaseReference!
    var added: Bool!
    var postArray = [String]()
    var userIdArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if receiveTextField == "" {
            nameLabel.text = "匿メンター"
        } else {
            nameLabel.text = receiveTextField
        }
        
        postTextField.delegate = self
        
        table.dataSource = self
        
        table.delegate = self
        
        postArray = []
        
        userIdArray = []
        
        self.dbRef = Database.database().reference()
        
        let user = self.dbRef.child("postID")
        user.observe(.value) { (snapshot: DataSnapshot) in
            if snapshot.hasChild("post") {
                self.added = true
            } else {
                self.added = false
            }
        }
        
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "cell")
        
        postTextField.placeholder = "whats going on?"
        
        update()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.postTextField.resignFirstResponder()
        return true
    }
    
    //セルの数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //セルの数をpostArrayの数にする
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! PostTableViewCell
        
        cell.name.text = userIdArray[indexPath.row]
        cell.post.text = postArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(postArray[indexPath.row])が選ばれました")
    }
    
    //更新ボタンの実装
    func update(){
        self.dbRef?.child("postID").observe(.childAdded, with: { [weak self](snapshot) -> Void in
            self?.userIdArray.append(String(describing: snapshot.childSnapshot(forPath: "username").value!))
            self?.postArray.append(String(describing: snapshot.childSnapshot(forPath: "post").value!))
            //ここでtableviewなどの更新を行う
            self?.table.reloadData()
        })
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func send(_ sender: AnyObject) {
        if postTextField.text == "" {
            let alert: UIAlertController = UIAlertController(title: "エラー" , message: "文字を入力してね"
                , preferredStyle: .alert)
            
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: {action in
                        print("OKボタンが押されました！")
                    }
                )
            )
            present(alert, animated: true, completion: nil)
            
        } else {
        self.dbRef.child("postID").childByAutoId().setValue(["username": self.nameLabel.text,"post": self.postTextField.text])
            
        
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}


