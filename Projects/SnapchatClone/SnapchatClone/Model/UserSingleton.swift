//
//  UserSingleton.swift
//  SnapchatClone
//
//  Created by Mert ÖZAN on 25.10.2023.
//

import Foundation

class UserSingleton {
    
    static let sharedUserInfo = UserSingleton()
    
    var email = ""
    var username = ""
    
    private init () {
        
    }
    
}
