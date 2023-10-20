//
//  ViewController.swift
//  AlertProject
//
//  Created by Mert ÖZAN on 5.10.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var passwordText2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func signupClicked(_ sender: Any) {
        
        if usernameText.text == ""{
            makeAlert(titleInput: "Error", messageInput: "Username not found")
        }else if passwordText.text == ""{
            makeAlert(titleInput: "Error", messageInput: "Password not found")
        }else if passwordText.text != passwordText2.text{
            makeAlert(titleInput: "Error", messageInput: "Password do not match")
        }else{
            makeAlert(titleInput: "Success", messageInput: "User ok")
        }
        
    }
    
    func makeAlert(titleInput: String, messageInput: String ){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (UIAlertAction) in
            print("Clicked")
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

