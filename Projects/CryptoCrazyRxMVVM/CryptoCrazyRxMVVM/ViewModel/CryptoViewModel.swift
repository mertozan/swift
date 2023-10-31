//
//  CryptoViewModel.swift
//  CryptoCrazyRxMVVM
//
//  Created by Mert ÖZAN on 31.10.2023.
//

import Foundation
import RxSwift
import RxCocoa

/* RxSwift ViewModel içinde bir yayın yapıyoruz. VC'den ViewModele subscribe olacağız. ViewModelde bir değişiklik olursa VC'ye abone olduğumuz verileri gözlemleyebilir olacağız. */

class CryptoViewModel {
    
    // Publish edeceğimiz şeyi içinde yazarız, veri tipini yazarız <> içinel
    let cryptos : PublishSubject<[Crypto]> = PublishSubject()
    // Hata mesajı için bir publishsubject oluşturuyoruz. Kullanıcı bir string hata mesajı göreceği için string tipini verdik
    let error : PublishSubject<String> = PublishSubject()
    // Loading yaparken bir animasyon koyabilmemizi sağlar. Genelde kullanılır. Bunu da fonksiyonun en başında kullanıyoruz. Loadingi true yapıyoruz. Loadingin verisi değiştiğinde VC'de ne yapılacak 
    let loading : PublishSubject<Bool> = PublishSubject()
    
    func requestData () {
        
        self.loading.onNext(true)   // Fonksiyonun cevabı gelince false yaparız. Cevap Result kısmında geliyor. Bu veri artık publishSubject olduğu için loading = true gibi bir tanımlama yapamıyoruz. onNext yani bir sonraki değeri ile değerlerini değiştirebiliyoruz.
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        Webservice().downloadCurrencies(url: url) { result in
            self.loading.onNext(false)
            switch result {
            case .success(let cryptos):
                self.cryptos.onNext(cryptos)
                
            case .failure(let error):
                switch error {
                case.parsingError:
                    self.error.onNext("Parsing error")
                case.serverError:
                    self.error.onNext("Server error")
                }
            }
        }
    }
    
}
