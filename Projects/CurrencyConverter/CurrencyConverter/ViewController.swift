//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Mert ÖZAN on 12.10.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        
        // 1) Request & Session
        // 2) Response & Data
        // 3) Parsig & JSON Serialization
        
        // HTTP bağlantılarına izin vermek için info > App Transport Security Settings > Okuna tıkla aşağı yöne dönsün tekrar +'ya bas > allow arbitrary Loads = YES yapacaksın
        
        // 1.Adım
        // Veri ağını bağladık
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=7b14204b7a1cc48b3a4e39c9420ab0e2")
        // İstediğimiz ağdan veri alışverişi için bunu kullanmamız lazım ;
        let session = URLSession.shared
        // completionHandler = Bir girdi veriyoruz, fonk çıktı veriyor. Çıktı veri, cevap ve hata çıktısı veriyor. Çıktıyı closure olarak veriyor
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                // 2.Adım
            } else {
                
                if data != nil {
                    do {
                        // jsonResponse bize any olarak geliyor, sözlük olmasını istiyoruz cast ediyoruz dict olarak. Verimizde String to başka veriler var o yüzden burada valueleri any verdik. Bir sonraki adımda kendi türlerini vereceğiz
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any >  // Sözlüklerle kullanmamızı sağlıyor
                        
                        // ASYNC
                        DispatchQueue.main.async {
                            //print(jsonResponse["success"])
                            if let rates = jsonResponse["rates"] as? [String : Any]{
                                
                                // Gelen verimizin türüne göre cast ediyoruz, burada double geliyor.
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                
                                if let turkish = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(turkish)"
                                }
                            }
                        }
                    } catch {
                        print("error")
                    }
                }
            }
        }
        // Bunu eklemeden işlemimiz başlamıyor.
        task.resume()
    }
    
}

