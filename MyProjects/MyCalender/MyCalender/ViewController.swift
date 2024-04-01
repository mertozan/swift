//
//  ViewController.swift
//  MyCalender
//
//  Created by Mert ÖZAN on 30.03.2024.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("mert")
        let vc = RegisterViewController()
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        present(navVc, animated: true)
        
//        if let currentUser = Auth.auth().currentUser {
//          // Kullanıcı oturum açmışsa, home sayfasına yönlendir
//          navigateToHome()
//        }

        
    }
    
    func navigateToHome(){
        //RegisterVc adında bir XIB dosyasından RegisterViewController oluştur
        let registerVC = RegisterViewController(nibName: "RegisterVc", bundle: nil)
        // RegisterViewController'ı push et (veya modally göster)
        navigationController?.pushViewController(registerVC, animated: true)

    }


}

