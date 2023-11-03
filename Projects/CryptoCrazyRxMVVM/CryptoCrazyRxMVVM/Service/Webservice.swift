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
    
    /* 
     
     Aşağıdaki yapıyı kendimiz de oluşturabiliriz. Örneğin aşağıdaki yapıda bir işlem yapılıyor. Yapıldıktan sonra data, cevap ya da error dönüyor.
     
     func downloadCurrencies(url: URL) {
         URLSession.share.dataTask(with: url) { data, response, error in
             //
         }
     Bu yapı completionhandler yapısı. Fonksiyonumuzda completionismi: @escaping ile bunu yapabiliyoruz. @escaping = Kaçan, iş bittikten sonra çalıştırılacak anlamına geliyor. Result success ya da failure simgeleyen bir yapı. Fonksiyonumuzda success durumunda Crypto listesi döndür, failure durumunda NSError döndür diyoruz(37). NSError kendi fonk hata mesajları ise kendimiz enum oluşturarak yaparız. Kendi enumumuzu oluşturduk CryptoError NSError yerine kendi errorumuzu yazdık(17-20).
     
     */

    
    func downloadCurrencies(url: URL, completion: @escaping (Result<[Crypto], CryptoError>) -> () ) {
        // URLSession urlye veri isteği attıktan sonra data cevap geldiğinde yapılacak işlemleri aşağısındaki satırlarda işlemleri yapıyoruz. Bu satırlar cevap geldikten sonra çalışıyor bir istek atıyor
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {  // Hata döndüyse
                completion(.failure(.serverError))  // Kendi yazdığımız completionu çağırdık. Result yerine . yazabiliriz. CryptoError veriyor. Onun yerine de . ile seçebiliriz.
                
            } else if let data = data { // Data döndüyse
                
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)   // JSONDecoder.decode = Bize bir type neye göre decode edeceğim diye sorar. Crypto listesine göre decode edecek, çünkü bize birden fazla veri geliyor liste olmalı.  Hata döndürebilir try ile yapıyoruz
                if let cryptoList = cryptoList { // CryptoList optional oldu bir üst satırda. Optional olmaktan çıkıyorsa
                    completion(.success(cryptoList))    // completion çağır .success
                } else {    // completion çağır. Veri gelmesine rağmen cryptoList'i çeviremedi
                    completion(.failure(.parsingError))
                }
            }
            
        }.resume() // URLSession bittiği yere .resume() dememiz lazım yoksa çalışmıyor.
    }
}
