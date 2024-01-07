//
//  APIManager.swift
//  ProtocolOrientedUIKit
//
//  Created by Mert ÖZAN on 2.01.2024.
//

import Foundation




class APIManager : UserService {
    
    /*
    static let shared = APIManager()
    private init (){}
    */
    
    func fetchUser(completion: @escaping(Result<User,Error>) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            DispatchQueue.main.async {
                if let user = try? JSONDecoder().decode([User].self, from: data).first{// first 1.elemanı aldık
                    completion(.success(user))
                } else {
                    completion(.failure(NSError()))
                }
                    
            }
        }.resume()
    }
    
    
    
    
}
