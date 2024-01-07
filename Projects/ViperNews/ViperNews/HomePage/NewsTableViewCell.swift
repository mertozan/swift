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
    
    var article : Article?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellOptions(article: Article) {
        self.titleLabel.text = article.title
        self.newsImageView.contentMode = .scaleAspectFill
        self.newsImageView.clipsToBounds = true
        getImageFromUrl(url: article.urlToImage)
        self.authorLabel.text = article.author
        self.article = article
        
    }
    
    func getImageFromUrl(url: String?) {
        if let imageUrl = URL(string: url ?? "String") {
            self.newsImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_image"))
        } else {
            // Geçersiz URL durumu için yer tutma görüntüsü
            self.newsImageView.image = UIImage(named: "placeholder_image")
        }
        
    }
    
}
