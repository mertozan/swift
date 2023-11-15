//
//  DetailsModels.swift
//  ViperNews
//
//  Created by Mert ÖZAN on 14.11.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Details {
    
    // MARK: Use cases
    enum NewsInfo {
        struct Request {
            let publishedDate : String
            let imageUrl : String
        }
        struct Response {
            let dateString : String
            let image : String
        }
        struct ViewModel {
            let dateString: String
            let image : String
        }
    }
    
    enum ButtonAction {
        struct Request {
            
        }
        struct Response {
            
        }
        struct ViewModel {
        
        }
    }
}
