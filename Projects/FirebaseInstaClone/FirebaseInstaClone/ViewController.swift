//
//  ViewController.swift
//  FirebaseInstaClone
//
//  Created by Mert ÖZAN on 12.10.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth


class ViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UYGULAMAYA GİRDİĞİMİZDE DAHA ÖNCE GİRİŞ YAPTIYSAK BUNUN VERİSİNİ CURRENTUSER İLE ALIYORUZ. BUNU SceneDelegate'de yapıyoruz.
        
        
    }

    
    
    @IBAction func signInClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")

                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)

                }
            }
            
            
        } else {
            makeAlert(titleInput: "Error!", messageInput: "Username/Password?")

        }
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            
            // Auth sınıfından auth objesi oluşturdu, Bir cevap, dataresult, kullanıcıyla ilgili veri veriyor ve Error veriyor
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                // Hata varsa
                if error != nil{
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error") // localizedDescription = Firebasenin kendi alert mesajı, ya ! koyacağız ya da default value olarak "Error" veriyoruz. Firebaseden hata mesajı gelmezse diye.
                    
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    
                }
            }
            
        } else {
            makeAlert(titleInput: "Error!", messageInput: "Username/Password?")
            
        }
        
        
        
    }
    
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

