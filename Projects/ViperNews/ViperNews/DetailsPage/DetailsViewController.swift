//
//  DetailsViewController.swift
//  ViperNews
//
//  Created by Mert ÖZAN on 9.11.2023.
//

import UIKit

protocol DetailsDisplayLogic: AnyObject {
    func display(viewModel: Details.NewsInfo.ViewModel)
    func buttonAction(viewModel: Details.ButtonAction.ViewModel)
    // image, action, likebutton
}

class DetailsViewController: UIViewController, DetailsDisplayLogic {
    func buttonAction(viewModel: Details.ButtonAction.ViewModel) {
        //
    }
    
    func display(viewModel: Details.NewsInfo.ViewModel) {
        dateLabel.text = viewModel.dateString
        
        if let imageUrl = URL(string: viewModel.image) {
            imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_image"))
        } else {
            imageView.image = UIImage(named: "placeholder_image")
        }
    }
    
    var interactor: DetailsBusinessLogic?
    
    var presenter : AnyPresenter?
    
    var article : Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
        view.addSubview(contentLabel)
        view.addSubview(imageView)
        view.addSubview(dateLabel)
        view.addSubview(showLikePage)
        view.backgroundColor = .white
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
        label.isHidden = false
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
    
    private let showLikePage : UIButton = {
        let button = UIButton()
        button.setTitle("Show Like Page", for: .normal)
        button.addTarget(self, action: #selector(showTapped), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        return button
    }()
    
    @objc func showTapped (){
        let nextViewController = presenter?.router?.makeLike() ?? UIViewController()
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLabel.text = article?.title
        authorLabel.text = article?.author
        contentLabel.text = article?.content
                
        interactor?.handle(request: Details.NewsInfo.Request(publishedDate: article?.publishedAt ?? "", imageUrl: article?.urlToImage ?? ""))
        
        titleLabel.frame = CGRect(x: 20, y: 20, width: view.frame.width - 40, height: 100)
        imageView.frame = CGRect(x: 20, y: titleLabel.frame.maxY, width: view.frame.width - 40, height: 230)
        authorLabel.frame = CGRect(x: 20, y: imageView.frame.maxY, width: view.frame.width - 40, height: 50)
        dateLabel.frame = CGRect(x: 20, y: authorLabel.frame.maxY, width: view.frame.width - 40, height: 50)
        let contentLabelSize = contentLabel.sizeThatFits(CGSize(width: view.frame.width - 40, height: CGFloat.greatestFiniteMagnitude))
        contentLabel.frame = CGRect(x: 20, y: dateLabel.frame.maxY + 5, width: view.frame.width - 40, height: contentLabelSize.height)
        showLikePage.frame = CGRect(x: 20, y: contentLabel.frame.maxY + 10, width: view.frame.width - 40, height: 50)
    
    }
}
