//
//  MusicianStruct.swift
//  Struct
//
//  Created by Mert ÖZAN on 20.10.2023.
//

import Foundation

struct MusicianStruct {
    
    var name : String
    var age : Int
    var instrument : String
    
    mutating func happyBirthday() {
        self.age += 1
    }
    
}
