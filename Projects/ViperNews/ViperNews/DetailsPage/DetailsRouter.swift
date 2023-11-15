//
//  DetailsRouter.swift
//  ViperNews
//
//  Created by Mert ÖZAN on 14.11.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailsRoutingLogic {
    func routeToSomeWhere()
}

class DetailsRouter: NSObject, DetailsRoutingLogic {
    weak var viewController: DetailsViewController?

    // MARK: Routing Logic
    
    func routeToSomeWhere() {
        
    }
}
