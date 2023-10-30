//
//  main.swift
//  MusicianClass
//
//  Created by Mert ÖZAN on 7.10.2023.
//

import Foundation

var mert = Musicians(name: "Mert", age: 22, instrument: "Keman", type: .Violenist)
print(mert.age)

mert.sing()

let ahmet = SuperMusician(name: "ahmet", age: 25, instrument: "Gitar", type: .LeadGuitar)
ahmet.sing()
ahmet.sing2()

