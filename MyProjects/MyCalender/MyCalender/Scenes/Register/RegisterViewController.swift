//
//  RegisterViewController.swift
//  MyCalender
//
//  Created by Mert ÖZAN on 30.03.2024.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let viewModel = RegisterViewModel()
    
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ViewModel'den dönen sonuçları dinle
//        viewModel.signUpResultHandler = { [weak self] result in
//          switch result {
//          case .success:
//            self?.makeAlert(titleInput: "Başarılı", messageInput: "Kayıt işlemi başarıyla tamamlandı.")
//          case .failure(let error):
//            self?.makeAlert(
//                titleInput: "Hata", messageInput: (error.localizedDescription) )
//          }
//        }

    }


    @IBAction func signUp(_ sender: Any) {
        guard let email = emailText.text, let password = passwordText.text else {
          // Eğer email ve password alınamazsa hata ver
          return
        }
        RegisterViewModel.signUp(email: email, password: password) { result in
                // Sonucu işle
                switch result {
                case .success:
                    // Başarılı durumda LoginViewController'ı push edin
                    let loginVC = LoginViewController() // LoginViewController'ı oluşturun
                    self.navigationController?.pushViewController(loginVC, animated: true) // Push işlemi
                    self.makeAlert(titleInput: "Başarılı", messageInput: "Kayıt işlemi başarıyla tamamlandı.")
                case .failure(let error):
                    // Hata durumunda kullanıcıya bilgi verebilir veya başka işlemler yapabilirsiniz
                    self.makeAlert(titleInput: "Başarısız", messageInput: error.localizedDescription )
                }
            }
    }
    
    @IBAction func signIn(_ sender: Any) {
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func makeAlert(titleInput : String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
