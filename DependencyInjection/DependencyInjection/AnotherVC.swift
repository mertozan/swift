//
//  AnotherVC.swift
//  DependencyInjection
//
//  Created by Mert ÖZAN on 7.01.2024.
//

import UIKit

class AnotherVC: UIViewController {
    
    private let providerProtocol : BackgroundProviderProtocol? // Aşağıdakileri eklememiz lazım. init, required
    
    init(providerProtocol : BackgroundProviderProtocol) {
        self.providerProtocol = providerProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // AnotherVC çağrılırken bir tane protocol verilecek dedik ve aşağıdaki satırı kullacanğız dedik, gelmezse white oldu. Protocolü enjecte ettik
        view.backgroundColor = providerProtocol?.backgroundColor ?? .white
    }
    

}
