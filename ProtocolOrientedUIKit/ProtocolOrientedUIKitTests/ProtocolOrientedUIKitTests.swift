//
//  ProtocolOrientedUIKitTests.swift
//  ProtocolOrientedUIKitTests
//
//  Created by Mert ÖZAN on 2.01.2024.
//

import XCTest
@testable import ProtocolOrientedUIKit

final class ProtocolOrientedUIKitTests: XCTestCase {
    
    private var userViewModel : UserViewModel!
    private var userService : MockUserService!
    private var output : MockUserViewModelOutput!

    override func setUpWithError() throws {
        userService = MockUserService()
        userViewModel = UserViewModel(userService: userService)
        output = MockUserViewModelOutput()
        userViewModel.output = output
    }

    override func tearDownWithError() throws {
        userService = nil
        userViewModel = nil
    }

    func testUpdateView_whenAPISuccess_showsEmailNameUserName() throws {
       let mockUser = User(id: 1, name: "Mert", username: "mertozan", email: "mert@gmail.com", address: Address(street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng: "")), phone: "", website: "", company: Company(name: "", catchPhrase: "", bs: ""))
        // Success olduğundaki test
        userService.fetchUserMockResult = .success(mockUser) // Fetchuser() çalışmadan önce bunu yazarsak fetcusers çalıştığında success geleceğini biliyoruz demek
        
        userViewModel.fetchUsers()
        
        XCTAssertEqual(output.updateViewArray.first?.userName, "mertozan")
    }

    func testUpdateView_whenAPIFailure_showsNoUser() throws {
       // Failure olduğundaki test
        userService.fetchUserMockResult = .failure(NSError())
        userViewModel.fetchUsers()
        XCTAssertEqual(output.updateViewArray.first?.name, "no user")
    }

}


class MockUserService : UserService{
    var fetchUserMockResult : Result<User, Error>?
    func fetchUser(completion: @escaping (Result<User, Error>) -> Void) {
        if let result = fetchUserMockResult {
            completion(result)
        }
    }
}

class MockUserViewModelOutput : UserViewModelOutput {
    var updateViewArray : [(name: String, email: String, userName: String)] = []
    func updateView(name: String, email: String, userName: String) {
        updateViewArray.append((name, email, userName))
    }
    
    
}
