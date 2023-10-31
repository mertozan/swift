//
//  ViewController.swift
//  CryptoCrazyRxMVVM
//
//  Created by Mert ÖZAN on 30.10.2023.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate /*UITableViewDataSource */{

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    let cryptoVM = CryptoViewModel()
    let disposeBag = DisposeBag()   // Disposebag = Hafızayı temizler
    
    var cryptosList = [Crypto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.delegate = self
        //tableView.dataSource = self
        
        view.backgroundColor = .black
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        setupBindings()
        cryptoVM.requestData()  // Veri indirilecek ve içindeki değişkenleri alıp gözlemleyebilmemiz lazım. Bu VM'de olan değişkenlere bir değişiklik olursa neler yapılacağını söylememiz lazım. Bunu bir fonk içinde yazacağız.
        
    }
    
    private func setupBindings() {
        
        cryptoVM
            .loading
            .bind(to: self.indicatorView.rx.isAnimating)    // True geldiğinde indicatorView'ın is animatingi trueye çevirir, false gelirse false çevirir.
            .disposed(by: disposeBag)
        
        cryptoVM
            .error
            .observe(on: MainScheduler.asyncInstance)   // Bu fonksiyon hangi threadde yapacağımızı soruyor. main threadde çalışacağını belirttik.
            .subscribe { errorString in
                print(errorString)
            }
            .disposed(by: disposeBag)
                
        /*
         cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { cryptos in
                self.cryptosList = cryptos
                self.tableView.reloadData()
            }
            .disposed(by: disposeBag)
        */
        
        // Tableviewda binding yapma
        
        cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(cellIdentifier: "CryptoCell", cellType: CryptoTableViewCell.self)) {row,item,cell in
                cell.item = item
            }
            .disposed(by: disposeBag)
            
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    /*
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptosList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = cryptosList[indexPath.row].currency
        content.secondaryText = cryptosList[indexPath.row].price
        cell.contentConfiguration = content
        return cell
    }
     
     */


}

