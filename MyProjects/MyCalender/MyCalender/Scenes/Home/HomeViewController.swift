//
//  HomeViewController.swift
//  MyCalender
//
//  Created by Mert ÖZAN on 30.03.2024.
//

import UIKit
import Firebase
import FirebaseAuth


class HomeViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func routeToRegister(_ sender: Any) {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    @IBAction func logOutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let vc = RegisterViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } catch {
            print("error")
        }
    }
    
}
