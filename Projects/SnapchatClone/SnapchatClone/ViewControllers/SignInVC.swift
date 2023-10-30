//
//  ViewController.swift
//  SnapchatClone
//
//  Created by Mert ÖZAN on 22.10.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    @IBAction func signInClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != ""{
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil{
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if emailText.text != "" &&  passwordText.text != "" && usernameText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    
                    let fireStoreDataBase = Firestore.firestore()
                    var fireStoreReference : DocumentReference? = nil
                    
                    let userDictionary = ["email": self.emailText.text!, "username": self.usernameText.text!] as! [String : Any]
                    
                    fireStoreReference = fireStoreDataBase.collection("UserInfo").addDocument(data: userDictionary, completion: { error in
                        //Error
                    })
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            makeAlert(titleInput: "Error", messageInput: "Email/Username/Password?")
        }
    }
    
    func makeAlert(titleInput : String, messageInput: String){
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

