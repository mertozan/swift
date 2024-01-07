//
//  LikeInteractor.swift
//  ViperNews
//
//  Created by Mert ÖZAN on 15.11.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LikeBusinessLogic {
    func handle(request: Like.Something.Request)
}

class LikeInteractor: LikeBusinessLogic {
    var presenter: LikePresentationLogic?
    
    // MARK: Business Logic

    func handle(request: Like.Something.Request) {
        let response = Like.Something.Response()
        presenter?.present(response: response)
    }
}
