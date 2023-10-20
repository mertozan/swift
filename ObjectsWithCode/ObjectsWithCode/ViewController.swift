//
//  ViewController.swift
//  ObjectsWithCode
//
//  Created by Mert ÖZAN on 3.05.2023.
//

import UIKit

class ViewController: UIViewController {
    var myLabel = UILabel()
    var myButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
                
                let width = view.frame.size.width   // Bütün viewımızın genişliğini alıyoruz.
                let height = view.frame.size.height // Yüksekliğini alıyoruz, bunları aşağıda myLabel için kullanabiliyoruz.
                
                myLabel.text = "Test Label"
                myLabel.textAlignment = .center
                myLabel.frame = CGRect(x: width * 0.5 - width * 0.8 / 2, y: height * 0.5 - 50/2, width: width * 0.8, height: 50) // Label nerede duracak
                view.addSubview(myLabel)    // Oluşumu ekledik
                
                
                myButton.setTitle("My Button", for: UIControl.State.normal) // Buton türü .normal
                myButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
                myButton.frame = CGRect(x: width * 0.5 - 100, y: height * 0.6, width: 200, height: 100)
                view.addSubview(myButton)
                
                myButton.addTarget(self, action: #selector(ViewController.myAction), for: UIControl.Event.touchUpInside) /* touchUpInside = Kullanıcı tıklama işlemi yapacağını belirtir. self = viewcontrolleri işaret eder, yani viewc içinden bir aksiyon çağırıyoruz. Hangi aksiyon, #selector fonksiyon olan aksiyonu çağırdığımızı belirtiyoruz. */
    }
    
    @objc func myAction() {
            myLabel.text = "Tapped"
        }


}

