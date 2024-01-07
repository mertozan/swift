//
//  LikeRouter.swift
//  ViperNews
//
//  Created by Mert ÖZAN on 15.11.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LikeRoutingLogic {
    func routeToSomeWhere()
}

class LikeRouter: NSObject, LikeRoutingLogic {
    weak var viewController: LikeViewController?

    // MARK: Routing Logic
    
    func routeToSomeWhere() {
        
    }
}
