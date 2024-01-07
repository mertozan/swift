//
//  BackgroundProvidingClass.swift
//  DependencyInjection
//
//  Created by Mert ÖZAN on 7.01.2024.
//

import Foundation
import UIKit

// Sağlayan, protokolü uygulayan sınıf. Bu sınıftan bir obje oluşturuduğumuzda her seferinde rastgele arka plan atayacak.
class BackgroundProvidingClass : BackgroundProviderProtocol {
    var backgroundColor: UIColor{
        let backgroundColors : [UIColor] = [.systemRed, .systemGray, .systemPink, .systemYellow]
        return backgroundColors.randomElement()!
    }
    
}
