//
//  Presenter.swift
//  CryptoViper
//
//  Created by Mert ÖZAN on 1.11.2023.
//

import Foundation

// talks to -> interactor, view, router
// Class, protocol

enum NetworkError : Error {
    case NetworkFailed
    case ParsingFailed
}


protocol AnyPresenter {
    
    var router : AnyRouter? {get set}   // Sadece okunacaksa get, okunup değiştirilecekse get set
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    func interactorDidDownloadCrypto(result: Result<[Crypto],Error>)
    
}

class CryptoPresenter : AnyPresenter {
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        // Değerler atanınca yapılacak işlemler, interactor ve presenter birbirine bağlandığında çalışacak 
        didSet {
            interactor?.downloadCryptos()
        }
    }
    
    var view: AnyView?
    
    // Bir 
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>) {
        switch result{
        case .success(let cryptos):
            view?.update(with: cryptos)
            print("update")
        case .failure(_):
            view?.update(with: "Try again later...")
            print("error")
        }
    }
    
    
}
