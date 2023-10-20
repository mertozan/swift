//
//  ViewController.swift
//  GestureRecognizerApp
//
//  Created by Mert ÖZAN on 5.10.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    var isSuccession1 = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changePic))
        
        imageView.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    @objc func changePic(){
        if imageView.image ==   UIImage(named: "succession1"){
            imageView.image = UIImage(named: "succession2")
            nameLabel.text = "Succession picture 2"
            isSuccession1 = false
        }else{
            imageView.image = UIImage(named: "succession1")
            nameLabel.text = "Succession picture 1"
            isSuccession1 = true
        }
    }
    
    


}

