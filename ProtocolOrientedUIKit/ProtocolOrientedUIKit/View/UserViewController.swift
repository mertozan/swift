//
//  ViewController.swift
//  ProtocolOrientedUIKit
//
//  Created by Mert ÖZAN on 2.01.2024.
//

import UIKit

class UserViewController: UIViewController, UserViewModelOutput {
    
    func updateView(name: String, email: String, userName: String) {
        self.nameLabel.text = name
        self.emailLabel.text = email
        self.usernameLabel.text = userName
    }
    
    
    private let viewModel : UserViewModel
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usernameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self    // Kendine eşitlememiz lazım artık kendi de bir userviewmodeloutput
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
//        fetchUsers()
        viewModel.fetchUsers()
    }
    
    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(emailLabel)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate(
            [
                
                nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),// X ekseninin ortası
                nameLabel.heightAnchor.constraint(equalToConstant: 60), // 60 piksel height
                nameLabel.widthAnchor.constraint(equalToConstant: 200), // 200 piksel width
                nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),  // Ekranın üstüne bağlı olarak 100 piksel bıraktı
                
                emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                emailLabel.heightAnchor.constraint(equalToConstant: 60),
                emailLabel.widthAnchor.constraint(equalToConstant: 200),
                emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
                
                usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                usernameLabel.heightAnchor.constraint(equalToConstant: 60),
                usernameLabel.widthAnchor.constraint(equalToConstant: 200),
                usernameLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10)
            
            ]
        )
//        nameLabel.text = "Name Label"
//        emailLabel.text = "Email Label"
//        usernameLabel.text = "Username Label"
        
        
    }
    
    /*
    private func fetchUsers() {
        APIManager.shared.fetchUser { result in
            switch result {
            case .success(let user):
                self.nameLabel.text = user.name
                self.usernameLabel.text = user.username
                self.emailLabel.text = user.email
                                
            case .failure:
                self.nameLabel.text = "No user found"
            }
        }
    }*/
    

}

