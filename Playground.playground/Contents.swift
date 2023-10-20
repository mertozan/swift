import UIKit
// Shift+Enter Bulunduğu satıra kadar olan kısmı çalıştırır

// Variables & Constants
var myNumber = 5 * 4 // var = Değişken
myNumber = 15
let myNumber2 = 20  // let = Sabit
//myNumber2 = 10

//String
var userName = "Mert"
userName.append("t")    // Sona karakter ekleme
userName.lowercased()   // Harfleri küçültme
userName.uppercased()   // Harfleri büyütme

// int & double & float
// integer = tam sayılar
let intNumber = 50
let intNumber2 = 4
intNumber / intNumber2

// double & float = kesirli sayılar
let doubleNumber = 50.0
var doubleNumber2 = 4.0
doubleNumber / doubleNumber2

// boolean = True False döner
var myBoolean = false
myBoolean = true

// Değişken tipi tanımlama ve tipini değiştirme

// Variable tipini önceden belirleme
var myString : String = "50"
let anotherNumber : Int = 10
// Değişkenlerin başına sınıfları koyarak dönüşüm yapabiliriz
let stringNumber : String = String(20)  // 20'yi stringe çevirdik


// define = Tanımlama, aşağıdaki gibi değişkeni tanımlama
let myVariable : String
// initialization = Başlatmak, tanımlanmış ama değer verilmemiş
myVariable = "Test"   // İlk defa burada tanımlandı
myVariable.uppercased() // Bizim değişkenimizi tümden değiştirmez, yukarıdaki değişkeni etkilemez, aslında yeni bir değişken türetir
print(myVariable)

// DİZİLER

var stringArray = ["eleman", "eleman2", "eleman3"] // Tipi String

var anyArray = ["eleman","eleman2", 2, true] as [Any] // Her türü alan tip, string metotlarını kullanamayız (.append, .uppercased() gibi)

// Array özellikler
stringArray.count   // sayı
stringArray.last    // sonuncu
stringArray[stringArray.count - 2]  // özel
stringArray.sort()  // alfabetik sırala

// SET = Sırasız, aynı elemandan yoktur 1 tanedir

var myArray = [1,2,3,4,4,5,5,6,7]
var mySet : Set = [1,2,3,4,5,3]
var mySet2 : Set = [1,5,6,7,8]
var myNewSet = Set(myArray) // Arrayi sete dönüştürme
var myset3 = mySet.union(mySet2)    // Setleri birleştirme, ortak elemanlar
print(myset3)

// DİCTİONARY = Sırasız, key and value

var myDictionary = ["İsim" : "Mert", "Soyisim" : "Özan"]
myDictionary["İsim"]
myDictionary["İsim"] = "Yiğit"
print(myDictionary)
myDictionary["Yeni key"] = "Yeni value"
print(myDictionary)
var myDictionary2 = ["Run" : 100, "Swim" : 200]
myDictionary2["Run"]

// LOOPS
var loopNumber = 5

while loopNumber < 10 {
    print(loopNumber)
    loopNumber += 1
}

var myFruitArray = ["Banana", "Apple", "Orange"]
for i in myFruitArray{
    print(i)
}

for integer in 1 ... 5{
    print(integer)
}

// İF &&, ||

if myNumber < 30{
    print("30'dan küçük")
}else if myNumber > 30 && myNumber < 40{
    print("30la 40 arası")
}else{
    print("30'dan büyük")
}

// FUNC
// Tanımlama
func myFunction () {
    print("my function")
}

// Fonksiyonu değer döndürme, Int, bool, String değer döndürebiliriz
func sumFunction(x:Int, y: Int) -> Int{
    return x + y
}
let dondurulmusDeger = sumFunction(x: 5, y: 10)
print(dondurulmusDeger)

func logicFunction(a: Int, b: Int) -> Bool{
    if a > b{
        return true
        //return "String değer"
    }else{
        return false
        //return "Başka bir string değer"
    }
}
logicFunction(a: -10, b: 0)

// OPSİYONELLER ? = Boş da olabilir değer de alabilir, ! = Kesinlikle değeri var
// ?? = Eğer verilen değer dönüşmüyor veya dönmüyorsa default değer atama yapar

var myName : String?
myName?.uppercased()

var myAge = "f"

var myInteger = (Int(myAge) ?? 0) * 5

// if let = ?? ile farkı burada kullanıcıya bir uyarı mesajı yazabiliyoruz

if let myNumber = Int(myAge){
    print(myNumber * 5)
}else{
    print("Wrong input")
}

// !! 2 ünlem kullanım

//let firstNumber = Int(firstText.text!)!  // text'den bir veri kesin gelecek, bu gelen veri kesinlikle inte dönüşebilecek

// SCOPES =  Tanımlanan fonksiyon > Class > gibi alttan üste doğru tanımlama yapılır. Fonksiyon içi tanımlananlar fonksiyon içinde çağrılabilir.


