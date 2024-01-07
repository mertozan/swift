//
//  ViewController.swift
//  DependencyInjection
//
//  Created by Mert ÖZAN on 7.01.2024.
//

import UIKit
import Swinject

class ViewController: UIViewController {

    // Bu VC'den başka bir VC'ye geçtiğimizde arka planın rengini değiştireceğiz. Arka planı, arka plan renklerini saklayan bir protokol ve bu protokolü uygulayan bir sınıf yazacağız. Bu sınıfın tanımlanmasını sadece bu VC'de yapacağız. Yani 2.VC'ye bu tanımlamalar enjecte edilmiş olacak
    
    // Swinject Kodları
    
    let container : Container = {
        let container = Container()
        // Container yapısında bazı şeyleri register ediyoruz. Burada kayıt ettiğimiz yapılar, örn sınıf, örn VC kendisi. Bunları burada kayıt ettiğimizde Swinject kullanarak bunları başka yerlerde çözümleme yapabiliyoruz. Swinjecte bu protocol, sınıf, VC'den ile ilgili işlem yapacağında bu şekilde işlem yapabilirsin diyoruz, bunun sayesinde diğer yerlerde bu dependencylere bağımlı olmadan oluşturma kolaylaşacak.
        
        container.register(BackgroundProvidingClass.self, factory: { resolver in
            return BackgroundProvidingClass()
        })
        
        container.register(AnotherVC.self) { resolver in
            let vc = AnotherVC(providerProtocol: resolver.resolve(BackgroundProvidingClass.self)!)
            return vc
        }

        return container
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        button.setTitle("Open Another VC", for: .normal)
        button.center = view.center
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        view.addSubview(button)
    }

    
    @objc private func buttonClicked() {
        // AnotherVC'nin tanımlanacağını Swinjecte öğrettik. Bunu çözümle dedik.
        if let viewController = container.resolve(AnotherVC.self){
            present(viewController, animated: true)
        }
        
    }

}

