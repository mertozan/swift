import UIKit

// Closure = İsimsiz fonksiyon denilebilir. Tek seferlik kullanacağımız bir fonksiyonu isimle tanımlamaya gerek kalmadan fonksiyon içinde parametre olarak tanımlıyoruz.

func sum(num1 : Int, num2: Int) -> Int {
    return num1 + num2
}

sum(num1: 5,num2: 5)

//Sum -> (Int, Int) -> Int

func calculate(num1: Int, num2: Int, myFunction : (Int, Int) -> Int ) -> Int {
    return myFunction(num1, num2)
}

calculate(num1: 5, num2: 2, myFunction: sum)

// sum fonksiyonunu calculate fonksiyonuna parametre olarak aldık.

// Closure = İsimsiz fonksiyon denilebilir. Tek seferlik kullanacağımız bir fonksiyonu isimle tanımlamaya gerek kalmadan fonksiyon içinde parametre olarak tanımlıyoruz. İsimsiz fonksiyon aşağıdaki gibi sadeleştirilebilir.

calculate(num1: 4, num2: 9, myFunction: { (num1: Int, num2: Int) -> Int in
    return num1 * num2
})

// Tipini belirtmemize gerek yok, swift algılıyor
calculate(num1: 4, num2: 9, myFunction: { (num1, num2) -> Int in
    return num1 * num2
})

// Dönecek değerin tipini belirtmemize gerek yok, swift algılıyor
calculate(num1: 4, num2: 9, myFunction: { (num1, num2) in
    return num1 * num2
})

// Yapılacak işlemlere parametre isimleri kullanmaya gerek yok, gelen değerlerin işlemlerini direk kod bloğu içerisinde yaptırabiliriz. $0 = 1.parametre, $1 = 2.parametre ... şeklinde gidiyor
calculate(num1: 4, num2: 9, myFunction: {$0 * $1})


// Map yapısı
let myArray = [10,20,30,40,50]

func test(num1 : Int) -> Int {
    return num1 / 5
}

myArray.map(test)

print(myArray.map({$0 / 5}))
