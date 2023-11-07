//
//  NewsTableViewCell.swift
//  ViperNews
//
//  Created by Mert ÖZAN on 7.11.2023.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {


    @IBOutlet var newsImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellOptions(image: UIImage, titleText: String, authorText: String) {
        self.titleLabel.text = titleText
        self.newsImageView.contentMode = .scaleAspectFill
        self.newsImageView.clipsToBounds = true
        self.newsImageView.image = image
        self.authorLabel.text = authorText
    }
    
}
