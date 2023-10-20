//
//  main.swift
//  Protocol
//
//  Created by Mert ÖZAN on 20.10.2023.
//

import Foundation

protocol Running {
     func myRun() // Fonksiyon gibi yapıları burada oluştururuz, fakat içini doldurmayız. Örneğin bir struct veya classtan bu fonksiyonu kullanmak istiyorsak orada çağırır ve bu fonksiyonun içini doldururuz. Bu bize ne sağlıyor? Örneğin classlarda fonksiyon oluşturduğumuzda ve bu classtan başka bir class kalıtım aldığında o classta o fonksiyon her zaman gelir. Ama protocolde sadece isteidğimiz fonksiyonları çağırabiliyoruz. Structlarda kalıtım yok, sahiplenme var, sahiplenmeyi protocllerden yapabiliriz.
}

// Aşağıdaki örnekte structtan ürettiğimiz bir objeden myRun fonksiyonunu çağırmak istedik. Eğer bu fonksiyonu objemizde kullanmak istiyorsak structta fonksiyonu tanımlamamız lazım. Protocolde sadece fonksiyonu oluşturmuş olduk. Running protocolünden her özelliği almamıza gerek kalmadı.
struct Bird : Running {
    func myRun() {
        print("Running")
    }
}

let tweety = Bird()
tweety.myRun()


// Sınıflarda ana sınıftaki fonskiyonu kalıtım ile alıyoruz ve oluşturduğumuz her objeye o fonksiyon tanımlanıyor. Bu fonksiyonu kullanmıyorsak protocoldeki gibi tanımlamak daha mantıklı olur.
class Animal {
    func running(){
        print("running")
    }
}


// Örneğin Animal sınıfındaki fonksiyonu Animal sınıfından kalıtım alan Dog sınıfından üretilen dog objesine de tanımlıyor. Yine aynı şekilde Animal sınıfından kalıtım alan Turtle sınıfından üretilen turtle objesi de bu fonksiyonu alıyor. Turtle koşamıyor ama yine de running() fonksiyonunu alıyor.
class Dog : Animal {
    
}

let dog = Dog()
dog.running()

class Turtle : Animal {
    
}

let turtle = Turtle()
turtle.running()
