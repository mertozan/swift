//
//  DetailsPresenter.swift
//  ViperNews
//
//  Created by Mert ÖZAN on 14.11.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailsPresentationLogic {
    func present(response: Details.NewsInfo.Response)
    func buttonAction(response: Details.ButtonAction.Response)
    
}

class DetailsPresenter: DetailsPresentationLogic {
    func buttonAction(response: Details.ButtonAction.Response) {
        //
    }
    
    weak var viewController: DetailsDisplayLogic?

    // MARK: Presentation Logic
    
    func present(response: Details.NewsInfo.Response) {
        let viewModel = Details.NewsInfo.ViewModel(dateString: response.dateString, image: response.image)
        viewController?.display(viewModel: viewModel)
    }
}
