//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Mert ÖZAN on 1.05.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var successionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonChange(_ sender: Any) {
        imageView.image = UIImage(named:"succession2")
    }
    
}

