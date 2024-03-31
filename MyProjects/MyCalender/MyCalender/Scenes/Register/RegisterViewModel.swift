//
//  RegisterViewModel.swift
//  MyCalender
//
//  Created by Mert ÖZAN on 30.03.2024.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import Firebase
import FirebaseFirestore

class RegisterViewModel{
    
    
    var signUpResultHandler: ((Result<Void, Error>) -> Void)?
    
    func registerUser(email: String, password: String) {
            // signUp fonksiyonunu çağırarak kayıt işlemini gerçekleştirin
        RegisterViewModel.signUp(email: email, password: password) { result in
                // Sonucu signUpResultHandler ile iletebilirsiniz
                self.signUpResultHandler?(result)
            }
        }
    static func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let fireStoreDataBase = Firestore.firestore()
                let userDictionary = ["email": email, "password": password] // Kullanıcı verileri
                fireStoreDataBase.collection("UserInfo").addDocument(data: userDictionary) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        }
    }
}






        
    
    
    
    
//    if emailText.text != "" &&  passwordText.text != "" && usernameText.text != "" {
//        Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
//            if error != nil {
//                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
//            } else {
//                
//                let fireStoreDataBase = Firestore.firestore()
//                var fireStoreReference : DocumentReference? = nil
//                
//                let userDictionary = ["email": self.emailText.text!, "username": self.usernameText.text!] as! [String : Any]
//                
//                fireStoreReference = fireStoreDataBase.collection("UserInfo").addDocument(data: userDictionary, completion: { error in
//                    //Error
//                })
//                self.performSegue(withIdentifier: "toFeedVC", sender: nil)
//            }
//        }
//    } else {
//        makeAlert(titleInput: "Error", messageInput: "Email/Username/Password?")
//    }

