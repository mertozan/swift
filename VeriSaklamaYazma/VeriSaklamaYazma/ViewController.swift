//
//  ViewController.swift
//  VeriSaklamaYazma
//
//  Created by Mert ÖZAN on 4.05.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Object ile veriyi alarak uygulama açıldığında en sonki veriyi görmemizi sağlıyor
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
        // Casting as? as!
        if let newName = storedName as? String{ // storedName Stringe çevirebilirsen çevir, as! olursa kesinlikle Stringe çevir
            nameLabel.text = "Name: \(newName)"
        }
        if let newBirthday = storedBirthday as? String{
            birthdayLabel.text = "Birthday: \(newBirthday)"
        }
    }

    @IBAction func saveClicked(_ sender: Any) {
        // Userdefaults ile kaydetmemk istediğimiz ve keyini yazıyoruz
        UserDefaults.standard.set(nameTextField.text!, forKey: "name")
        UserDefaults.standard.set(birthdayTextField.text!, forKey: "birthday")
        
        nameLabel.text = "Name: \(nameTextField.text!)"
        birthdayLabel.text = "Birthday: \(birthdayTextField.text!)"
               
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
        if(storedName as? String) != nil{
            UserDefaults.standard.removeObject(forKey: "name")
            nameLabel.text = "Name:"
        }
        
        if(storedBirthday as? String) != nil{
            UserDefaults.standard.removeObject(forKey: "birthday")
            birthdayLabel.text = "Birthday:"
        }
        
        
    }
    
}

