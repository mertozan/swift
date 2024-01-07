//
//  DependencyAnlamaOrnek.swift
//  DependencyInjection
//
//  Created by Mert ÖZAN on 7.01.2024.
//

//import Foundation
//
//struct Instrument {
//    var name : String
//    var brand : String
//}
//
//
//struct Band {
//    var name : String
//}
//
//// Müzisyeni bağlayan bazı structlar var bunları da burada alıyoruz. İnstrument band bunlara bağlı
//
//struct Musician {
//    var instrument : Instrument
//    var band : Band
//    var name : String
//    var age : Int
//}
//
//// Aşağıdaki Musican yapısından bir obje oluşturmak istediğimizde oluşturmamız gerekn başka yapılar var. Yani bu yapılara bağımlıyız. Bunlar musician için bir dependency oluyor. Bunları oluşturmadan Musican structtan bir obje oluşturamayız. Dependency Injection yapısını anlatmak için yapılan bir örnek
//let guitar = Instrument(name: <#T##String#>, brand: <#T##String#>)
//let metallica = Band(name: <#T##String#>)
//let james = Musician(instrument: <#T##Instrument#>, band: <#T##Band#>, name: <#T##String#>, age: <#T##Int#>)
