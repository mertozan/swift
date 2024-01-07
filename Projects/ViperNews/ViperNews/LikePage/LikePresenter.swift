//
//  LikePresenter.swift
//  ViperNews
//
//  Created by Mert ÖZAN on 15.11.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LikePresentationLogic {
    func present(response: Like.Something.Response)
}

class LikePresenter: LikePresentationLogic {
    weak var viewController: LikeDisplayLogic?

    // MARK: Presentation Logic
    
    func present(response: Like.Something.Response) {
        let viewModel = Like.Something.ViewModel()
        viewController?.display(viewModel: viewModel)
    }
}
