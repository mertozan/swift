//
//  main.swift
//  Struct
//
//  Created by Mert ÖZAN on 20.10.2023.
//

import Foundation

// Classlarda initialize etmemiz lazım.
let classJames = MusicianClass(nameInput: "James", ageInput: 50, instrumentInput: "Guitar")
// Structlarda initialize etmemize gerek yok, free initialize var. Sturct propertylerini değiştireceksek var ile tanımlamamız lazım.
var structJames = MusicianStruct(name: "James", age: 50, instrument: "Guitar")

print(classJames.age)
print(structJames.age)

classJames.age = 51
print(classJames.age)
structJames.age = 51
print(structJames.age)

let copyOfClassJames = classJames
var copyOfStructJames = structJames
print("------------")
print(copyOfClassJames.age)
print(copyOfStructJames.age)

copyOfClassJames.age = 52
copyOfStructJames.age = 52

print("------------")
// Kopya sınıf ile asıl sınıfın değerleri de değişiyor. Çünkü 2 farklı referans tek bir obje içerisinde işlem yapıyor.
print(copyOfClassJames.age) // 52
print(copyOfStructJames.age)    // 52

print(classJames.age)   // 52 -> 51 olması lazım, ama tek bir value var 2 referans üstünde en son olanı alıyor.
print(structJames.age)  // 51


// Reference Types -> Class
// Copy -> Same object new reference -> 1 object + 2 Reference

// Value Types -> Struct
// Copy -> new object -> 2 Objects


//Function vs Mutating Function
print("Function vs Mutating Function")
print(classJames.age)
classJames.happyBirthday()
print(classJames.age)
print("------------")
print(structJames.age)
structJames.happyBirthday()
print(structJames.age)


// TUPLE = Birden fazla veriyi aynı koleksiyon içerisinde kullanmamızı sağlıyor. Diziye benziyor
print("TUPLE")

let myTuple = (1,3)
print(myTuple.0)
let myTuple2 = ("mert",100)
let mytuple4 = (10,[10,20,30])
print(mytuple4.1[1])

// Tuple'lerin alacağı değerleri belirleyebiliriz
let predefinedTuple : (String, String)
predefinedTuple.0 = "Mert"
predefinedTuple.1 = "Yigit"
print(predefinedTuple)

let newTuple = (name:"Mert", metallica: true)
print(newTuple.metallica)
print(newTuple.name)

// GUARD LET = Daha güvenli işlemler için kullanıyoruz. if let ile benzer. Baştan eğer işlemi yapamazsan else kısmını yap diyoruz. Ama if lette yapabilirsen yap diyip else kısmını yazmasak da oluyor.
print("GUARD LET")
let myNumber = "5"

// MyIntegeri çevir ve oluştur yapamazsan else düş
func converttoIntegerGuard (stringInput : String) -> Int{
    guard let myInteger = Int(stringInput) else {
        return 0
    }
    return myInteger
}

func converttoIntegerIf (stringInput : String) -> Int{
    if let myInteger = Int(stringInput){
        return myInteger
    } else {
        return 0
    }
}

print(converttoIntegerIf(stringInput: myNumber))
print(converttoIntegerGuard(stringInput: myNumber))


// SWİTCH CASE
print("SWİTCH CASE")
let myNum = 11
let myRemainder = myNum % 2
print(myRemainder)

/*
if myRemainder == 1 {
    print("it's 1")
} else if myRemainder == 2 {
    print("it's 2")
} else if myRemainder == 3 {
    print("it's 3")
}
 */
// Yukarıdaki gibi çok fazla else if durumlarında switch case kullanabiliriz

switch myRemainder {
case 1...3: // 1-3 arası gibi çalıştırabiliriz
    print("it's a 1")
case 2:
    print("it's a 2")
case 3:
    print("it's a 3")
default:
    print("none of the above")
}
