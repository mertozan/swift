//
//  ViewController.swift
//  TimerProject
//
//  Created by Mert ÖZAN on 5.10.2023.
//

import UIKit
class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    var timer = Timer()
    var counter = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter = 10
        timerLabel.text = "Time: \(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
    }
    
    @objc func timerFunction(){
        
        timerLabel.text = "Time: \(counter)"
        counter -= 1
        
        if counter == 0 {
            timer.invalidate()
            timerLabel.text = "Time's over"
        }
        
    }

    @IBAction func buttonClicked(_ sender: Any) {
        print("Clicked")
    }
    
}

