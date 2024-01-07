//
//  UserViewModel.swift
//  ProtocolOrientedUIKit
//
//  Created by Mert ÖZAN on 7.01.2024.
//

import Foundation

class UserViewModel {
    
    private let userService : UserService
    // Weak var = Bu değişken sadece buna erişildiğinde initialize edilecek demek. Weak var ile
    weak var output : UserViewModelOutput?
    
    init(userService: UserService ) {
        self.userService = userService
    }
    
    
    func fetchUsers() {
        
        userService.fetchUser {[weak self] result in
            switch result{
            case .success(let user):
                self?.output?.updateView(name: user.name, email: user.email, userName: user.username)
//                print(user)
            case .failure(_):
//                print("error")
                self?.output?.updateView(name: "no user", email: "", userName: "")
            }
        }

    }
}
