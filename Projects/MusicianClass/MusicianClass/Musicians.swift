//
//  Musicians.swift
//  MusicianClass
//
//  Created by Mert ÖZAN on 7.10.2023.
//

import Foundation

enum MusicianType{
    case LeadGuitar
    case Vocalist
    case Drummer
    case Bassist
    case Violenist
}

class Musicians{
    // Property
    var name : String
    var age : Int
    var instrument : String
    var type : MusicianType
    
    // İnitializor = Burada tanımlama yaparak obje oluşturulan yerde değerlerini veriyoruz. Sınıf içinde değer vermiyoruz.
    init(name: String, age: Int, instrument: String, type: MusicianType) {
        self.name = name
        self.age = age
        self.instrument = instrument
        self.type = type
    }
    
    func sing(){
        print("Şarkı söylüyor")
    }
}
