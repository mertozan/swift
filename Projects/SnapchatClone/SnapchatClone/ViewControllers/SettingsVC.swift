//
//  SettingsVC.swift
//  SnapchatClone
//
//  Created by Mert ÖZAN on 22.10.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    

    @IBAction func logoutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toSignInVC", sender: nil)
        } catch {
            print("Error")
        }
    }
    

}
