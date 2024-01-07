//
//  BackgroundProviderProtocol.swift
//  DependencyInjection
//
//  Created by Mert ÖZAN on 7.01.2024.
//

import Foundation
import UIKit

// Provider = Sağlayıcı
protocol BackgroundProviderProtocol {
    
    var backgroundColor : UIColor {
        get
    }
    
}
