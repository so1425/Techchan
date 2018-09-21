//
//  PostViewController.swift
//  Techchan
//
//  Created by so1425 on 2018/09/17.
//  Copyright © 2018年 so1425. All rights reserved.
//

import UIKit
import Firebase

class PostViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var postTextField: UITextField!
    @IBOutlet var table: UITableView!

    var receiveTextField: String!
    var dbRef: DatabaseReference!
    var postArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if receiveTextField == "" {
            nameLabel.text = "匿メンター"
        } else {
            nameLabel.text = receiveTextField
        }
        
        postTextField.delegate = self
        
        table.dataSource = self
        
        postArray = []
        
        dbRef = Database.database().reference()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = postArray[indexPath.row]
        
        return cell!
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
            let post = ["post": postTextField.text!]
            let username = ["username": nameLabel.text!]
            dbRef.child("user/01").setValue(post)
            dbRef.child("user/01").setValue(username)
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
