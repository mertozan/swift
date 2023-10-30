//
//  SnapVC.swift
//  SnapchatClone
//
//  Created by Mert ÖZAN on 22.10.2023.
//

import UIKit
import ImageSlideshow


class SnapVC: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var selectedSnap : Snap?
    var inputArray = [KingfisherSource]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let snap = selectedSnap {
            
            timeLabel.text = "Time Lef: \(snap.timeDifference)"
            print(snap.timeDifference)
            
            for imageUrl in snap.imageUrlArray {
                inputArray.append(KingfisherSource(urlString: imageUrl)!)
            }
            
            let imageSlideShow = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width * 0.95, height: self.view.frame.height * 0.9))
            imageSlideShow.backgroundColor = UIColor.white
            
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray // Güncel olan sayfanın indicatorü
            pageIndicator.pageIndicatorTintColor = UIColor.black    // Geri kalan sayfaları gösteren indicator
            imageSlideShow.pageIndicator = pageIndicator
            
            imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
            imageSlideShow.setImageInputs(inputArray)
            self.view.addSubview(imageSlideShow)
            self.view.bringSubviewToFront(timeLabel)
            
        }
        
    }
    

    

}
