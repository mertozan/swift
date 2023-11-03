//
//  Router.swift
//  CryptoViper
//
//  Created by Mert ÖZAN on 1.11.2023.
//

import Foundation
import UIKit

// Uygulama ilk açıldığında nereden başlayacak gibi işlemleri burada yapıyoruz. EntryPoint belirteceğiz, giriş noktası başlangıç
// Class, protocol


// typealias = EntryPoint gördüğün her yerde EntryPoint AnyView & UIViewController demek.
typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry : EntryPoint? {get}
    static func startExecution() -> AnyRouter
}

class CryptoRouter : AnyRouter {
    
    var entry: EntryPoint?
    
    static func startExecution() -> AnyRouter {
        
        let router = CryptoRouter()
        
        var view : AnyView = CryptoViewController()
        var presenter : AnyPresenter = CryptoPresenter()
        var interactor : AnyInteractor = CryptoInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        
        return router
    }
    // En son SceneDelegateye gitmemiz lazım. 
    
    
}
