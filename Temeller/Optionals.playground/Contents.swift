import UIKit

var myName : String? // Sonuna ? koymak opsiyonel yap demek, yani değeri belki olur belki olmaz.

myName?.uppercased() /* myName ? işareti koyunca değer belki verilir belki verilmez,
                      verilmezse işlem yapmaz. ! koyarsak kesinlikle bunun değeri olacak demek
                      */
// != Kesinlikle sonuna ! koyduğumuz verinin değeri olacak diyoruz

var myAge = "rr"

var myInteger = (Int(myAge) ?? 0) * 5 // Eğer myAge int ise işlemi yap, değilse

if let myNumber = Int(myAge) {  // Eğer bu koşul sağlanıyorsa yap yoksa else
    print(myNumber * 5)
} else {
    print("wrong input")
}





