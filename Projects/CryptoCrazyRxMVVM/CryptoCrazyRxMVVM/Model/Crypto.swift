//
//  Crypto.swift
//  CryptoCrazyRxMVVM
//
//  Created by Mert ÖZAN on 30.10.2023.
//

import Foundation



/*  Codable = Hem Decodable hem Encodable. Hem decode hem encode edilebilir. Swift için özel
    Decodable = Gelen JSON verisini kendimiz okuyacabileceğimiz şekilde çeviriyorsak decode etmiş oluyoruz.
    Encodable = Bazen biz bir veriyi alıp encode edip JSON şeklinde sunucuya yollamamız gerekir.
    Quick Type = JSON dosyalarının içindeki struct yapılarını oluşturan site
 
 
 */

struct Crypto : Decodable {
    let currency : String
    let price : String
    
}
