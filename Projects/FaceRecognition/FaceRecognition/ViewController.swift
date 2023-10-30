//
//  ViewController.swift
//  FaceRecognition
//
//  Created by Mert ÖZAN on 11.10.2023.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInClicked(_ sender: Any) {
        // Aşağıdaki işlemlerden sonra gidip info kısmından Face ID Usage Description'a açıklama yazmalıyız.
        let authContext = LAContext()
        
        var error: NSError?
        // Kullandığımız cihaz verdiğimiz durumu değerlendirebiliyorsa(biometrik) > devam değilse error
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            // Biyometriği değerlendir > doğru mu değil mi, ona göre işlemlerimizi yapıyoruz
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") { success, error in
                if success == true {
                    // Successful auth
                    // DispatchQueue ile main threaddde çalıştırmamız lazım yoksa app çöker
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                    }
                } else {
                    DispatchQueue.main.async{
                        self.myLabel.text = "Error!!"
                    }
                    
                }
            }
        }
        }
        
    }

