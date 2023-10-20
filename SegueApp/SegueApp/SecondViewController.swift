//
//  SecondViewController.swift
//  SegueApp
//
//  Created by Mert ÖZAN on 5.05.2023.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var SecondLabel: UILabel!
    var myName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = myName

     
    }

}
