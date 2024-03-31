//
//  LoginViewController.swift
//  MyCalender
//
//  Created by Mert ÖZAN on 30.03.2024.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func signUpClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
