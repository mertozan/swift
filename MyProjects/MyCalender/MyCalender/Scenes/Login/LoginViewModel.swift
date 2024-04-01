//
//  LoginViewModel.swift
//  MyCalender
//
//  Created by Mert ÖZAN on 30.03.2024.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import Firebase

class LoginViewModel{
    func loginUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    
    
}
