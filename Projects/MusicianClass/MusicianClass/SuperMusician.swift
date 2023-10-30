//
//  SuperMusician.swift
//  MusicianClass
//
//  Created by Mert ÖZAN on 7.10.2023.
//

import Foundation

// Musicians özelliklerini alıp üstüne kendine ait özellikler yazıyoruz. Inheritence

class SuperMusician : Musicians{
    
    func sing2(){
        print("Yeni şarkı söylüyor")
    }
    
    // Kalıtım aldığı sınıfın üstüne yeni bir fonksiyon yazmamızı sağlıyor ve bu fonksiyonu istersek alıp üstüne yeni işlemler eklememizi sağlıyor
    override func sing(){
        super.sing()
        print("Yeni sözler")
    }
}
