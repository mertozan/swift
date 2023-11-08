//
//  View.swift
//  ViperNews
//
//  Created by Mert ÖZAN on 6.11.2023.
//

import Foundation
import UIKit
import SDWebImage

protocol AnyView {
    
    var presenter : AnyPresenter? {get set}
    
    func update(with news: [Article])
    func update(with error: String)
}


class DetailsViewController : UIViewController{
    
    var presenter : AnyPresenter?
    // title yazınca hata veriyor. Bunu sor
    
    var articles : [Article] = []
    
    var baslik: String = ""
    var author: String? = ""
    var content: String = ""
    var publishedDate: String = ""
    var imageUrl: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
        view.addSubview(contentLabel)
        view.addSubview(imageView)
    }
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
        }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let authorLabel : UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
        
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let contentLabel : UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
        
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLabel.text = baslik
        authorLabel.text = author
        contentLabel.text = content
        
        dateLabel.text = publishedDate
        
        if let imageUrl = URL(string: imageUrl) {
            imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_image"))
                } else {
                    // Geçersiz URL durumu için yer tutma görüntüsü
                    imageView.image = UIImage(named: "placeholder_image")
                }
        
        titleLabel.frame = CGRect(x: 20, y: 20, width: view.frame.width - 40, height: 100)
        imageView.frame = CGRect(x: 20, y: titleLabel.frame.maxY, width: view.frame.width - 40, height: 230)
        authorLabel.frame = CGRect(x: 20, y: imageView.frame.maxY + 10, width: view.frame.width - 40, height: 50)
        dateLabel.frame = CGRect(x: 20, y: authorLabel.frame.maxY + 5, width: view.frame.width - 40, height: 50)
        let contentLabelSize = contentLabel.sizeThatFits(CGSize(width: view.frame.width - 40, height: CGFloat.greatestFiniteMagnitude))
        contentLabel.frame = CGRect(x: 20, y: dateLabel.frame.maxY + 5, width: view.frame.width - 40, height: contentLabelSize.height)
    }
}


class NewsViewController : UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource {

    var presenter: AnyPresenter?
    
    var articles : [Article] = []
        
        private var tableView : UITableView = {
            let table = UITableView()
            table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            table.isHidden = true
            return table
            
        } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        
    }
    
    private let messageLabel : UILabel = {
           let label = UILabel()
            label.isHidden = false
            label.text = "Downloading ..."
            label.font = UIFont.systemFont(ofSize: 20)
            label.textColor = .black
            label.textAlignment = .center
            return label
        }()
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell
        cell?.setCellOptions(image: UIImage(systemName: "folder.fill") ?? UIImage(), titleText: articles[indexPath.row].title, authorText: articles[indexPath.row].author!)
        if let imageUrl = URL(string: articles[indexPath.row].urlToImage ?? "String") {
            cell!.newsImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_image"))
                } else {
                    // Geçersiz URL durumu için yer tutma görüntüsü
                    cell!.newsImageView.image = UIImage(named: "placeholder_image")
                }
        return cell ?? UITableViewCell()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        messageLabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 - 25, width: 200, height: 50)
    }
    
    
    func update(with articles: [Article]) {
        DispatchQueue.main.async {
            self.articles = articles
            self.messageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.articles = []
            self.tableView.isHidden = true
            self.messageLabel.text = error
            self.messageLabel.isHidden = false

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = DetailsViewController()
        nextViewController.baslik = articles[indexPath.row].title
        nextViewController.author = articles[indexPath.row].author
        nextViewController.content = articles[indexPath.row].content
        nextViewController.publishedDate = articles[indexPath.row].publishedAt
        nextViewController.imageUrl = articles[indexPath.row].urlToImage!
        self.present(nextViewController, animated: true, completion: nil)
    }
    
}


