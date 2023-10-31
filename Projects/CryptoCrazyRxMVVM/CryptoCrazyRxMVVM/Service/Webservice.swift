//
//  Webservice.swift
//  CryptoCrazyRxMVVM
//
//  Created by Mert ÖZAN on 30.10.2023.
//

import Foundation

enum CryptoError : Error {
    case serverError    // Sunucu hatası
    case parsingError   // Veri geldi, veri işlenemedi hatası
}

class Webservice {
    
    /* Aşağıdaki yapıyı kendimiz de oluşturabiliriz. Örneğin aşağıdaki yapıda bir işlem yapılıyor. Yapıldıktan sonra data, cevap ya da error dönüyor. 
     Bu yapı completionhandler yapısı. Fonksiyonumuzda completionismi: @escaping ile bunu yapabiliyoruz. @escaping = Kaçan, iş bittikten sonra çalıştırılacak anlamına geliyor. Result succeess ya da failure simgeleyen bir yapı. Success durumunda Crypto listesi döndür, failure durumunda NSError döndür diyoruz. NSError kendi fonk hata mesajları ise kendimiz enum oluşturarak yaparız. Kendi enumumuzu oluşturduk CryptoError NSError yerine kendi errorumuzu yazdık */
    
    func downloadCurrencies(url: URL, completion: @escaping (Result<[Crypto], CryptoError>) -> () ) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {  // Hata döndüyse
                completion(.failure(.serverError))  // resul yerine . yazabiliriz. CryptoError veriyor. Onun yerine de . ile seçebiliriz.
                
            } else if let data = data { // Data döndüyse
                
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)   // Hata döndürebilir try ile yapıyoruz
                if let cryptoList = cryptoList { // CryptoList optional oldu bir üst satırda. Optional olmaktan çıkıyorsa
                    completion(.success(cryptoList))
                } else {    // Veri gelmesine rağmen cryptoList'i çeviremedi
                    completion(.failure(.parsingError))
                }
            }
            
        }.resume() // URLSession bittiği yere .resume() dememiz lazım yoksa çalışmıyor.
    }
}
