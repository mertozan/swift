//
//  Presenter.swift
//  ViperNews
//
//  Created by Mert ÖZAN on 6.11.2023.
//

import Foundation

enum NetworkError : Error {
    case NetworkFailed
    case ParsingFailed
}

protocol AnyPresenter {
    
    var interactor : AnyInteractor? {get set}
    var router : AnyRouter? {get set}
    var view : AnyView? {get set}
    
    func interactorDidDownloadNews (result: Result<[Article], Error>)
    
}

class NewsPresenter : AnyPresenter {
    
    var router: AnyRouter?
    
    var view: AnyView?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.downloadNews()
        }
    }
    
    
    func interactorDidDownloadNews(result: Result<[Article], Error>) {
        switch result {
        case .success(let articles):
            view?.update(with: articles)
            print("update")
        case .failure(let error):
            view?.update(with: "Try again later")
            print(error)
            print("error")
        }
    }
    
    
    
    
    
}
