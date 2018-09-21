//
//  ViewController.swift
//  Techchan
//
//  Created by so1425 on 2018/09/17.
//  Copyright © 2018年 so1425. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let postViewController: PostViewController = segue.destination as! PostViewController
        postViewController.receiveTextField = self.nameTextField.text
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.nameTextField.resignFirstResponder()
        return true
    }
}

