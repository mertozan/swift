//
//  ViewController.swift
//  SegueApp
//
//  Created by Mert ÖZAN on 5.05.2023.
//

import UIKit

class ViewController: UIViewController {
    var userName = ""
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var FirstLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func nextClicked(_ sender: Any) {
        userName = nameText.text!
        performSegue(withIdentifier: "toSecondVC", sender: nil) 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toSecondVC"){
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.myName = userName
            
        }
    }
    /* Burada yaptığımız işlem = Buttonda performSegue ile diğer VC'ye bağlantımızı oluşturduk. Hemen öncesinde userName diye boş bir string oluşturduk.
     Ardından prepare kısmında SecondVC'ye git oradaki myName objesini buradaki userName ile değiştir dedik. SecondVC'deki labela da myName değişkeninin değerini
     verdik.  */
}

