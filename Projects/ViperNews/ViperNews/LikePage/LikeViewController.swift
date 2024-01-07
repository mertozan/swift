//
//  LikeViewController.swift
//  ViperNews
//
//  Created by Mert ÖZAN on 15.11.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LikeDisplayLogic: AnyObject {
    func display(viewModel: Like.Something.ViewModel)
}

class LikeViewController: UIViewController, LikeDisplayLogic {
    
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    var interactor: LikeBusinessLogic?
    var router: (NSObjectProtocol & LikeRoutingLogic)?

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = Like.Something.Request()
        interactor?.handle(request: request)
        view.backgroundColor = .white
    }

    // MARK: Requests

    func display(viewModel: Like.Something.ViewModel) {
    
    }
}
