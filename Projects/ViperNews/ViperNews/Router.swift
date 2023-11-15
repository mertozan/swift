//
//  Router.swift
//  ViperNews
//
//  Created by Mert ÖZAN on 6.11.2023.
//

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    
    var entry : EntryPoint? {get}
    static func startExecution() -> AnyRouter
    func makeDetails(article: Article) -> UIViewController?
    
}

class NewsRouter : AnyRouter {
    
    var entry: EntryPoint?
    
    static func startExecution() -> AnyRouter {
        
        let router = NewsRouter()
        
        var view : AnyView = NewsViewController()
        var presenter : AnyPresenter = NewsPresenter()
        var interactor : AnyInteractor = NewsInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
    func makeDetails(article: Article) -> UIViewController? {
        let viewController = DetailsViewController(nibName: "DetailsView", bundle: nil)
        let interactor = DetailsInteractor()
        let presenter = DetailsPresenter()
        let router = DetailsRouter()
        viewController.interactor = interactor
        viewController.article = article
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
    
    
}
