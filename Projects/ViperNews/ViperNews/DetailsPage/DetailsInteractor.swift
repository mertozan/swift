//
//  DetailsInteractor.swift
//  ViperNews
//
//  Created by Mert ÖZAN on 14.11.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailsBusinessLogic {
    func handle(request: Details.NewsInfo.Request)
    func buttonAction(request: Details.ButtonAction.Request)
}

class DetailsInteractor: DetailsBusinessLogic {
    func buttonAction(request: Details.ButtonAction.Request) {
        //
    }
    
    var presenter: DetailsPresentationLogic?
    var dateString: String?
    
    // MARK: Business Logic

    func handle(request: Details.NewsInfo.Request) {
        // DateFormatter kullanarak tarih verisini Date türüne dönüştürme
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        if let date = dateFormatter.date(from: request.publishedDate) {
            // Tarih verisini Date türünden bir değişkene dönüştürdük, şimdi bunu bir String'e dönüştürelim
            let stringDateFormatter = DateFormatter()
            stringDateFormatter.dateFormat = "dd/MM/yyyy" // Tarih formatını istediğiniz gibi ayarlayabilirsiniz
            dateString = stringDateFormatter.string(from: date)
        }
        
        
        presenter?.present(response: Details.NewsInfo.Response(dateString: dateString ?? "", image: request.imageUrl))
    }
    
    
}
