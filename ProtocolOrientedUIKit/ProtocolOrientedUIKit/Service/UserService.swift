//
//  UserService.swift
//  ProtocolOrientedUIKit
//
//  Created by Mert ÖZAN on 7.01.2024.
//

import Foundation

// Soyutladık
protocol UserService {
    func fetchUser(completion: @escaping(Result<User,Error>) -> Void)
}
