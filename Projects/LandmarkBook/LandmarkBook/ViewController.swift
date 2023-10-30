//
//  ViewController.swift
//  LandmarkBook
//
//  Created by Mert ÖZAN on 7.10.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var landmarkNames = [String]()
    var landmarkImages = [UIImage]()
    
    var chosenLandmarkName = ""
    var chosenLandmarkImage = UIImage()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* UITableViewDelegate ve UITableViewDataSource protokollerini çağırdık. Bu protokolleri çağırdığımızda ve TableView kullanmak istediğimizde numberOfRowInSection ve cellForRowAt fonksiyonlarını çağırmak zorundayız. Satırlardaki isimleri ve resimleri ayrı ayrı dizilere atadık. Kaç satır olacağını isim dizisinin sayısı kadar verdik. Hücrelerde gösterilecek verileri indexpath sınıflardaki indexlerle eşleştirdik. DidSelectRowAt fonksiyonu rowlara tıklanınca yapılacak işlemleri sağlar. Sınıfların dışında tanımladığımız değişkenlerle burada tıklanan rowlara isimleri ve resimleri atadık. Bundan sonrasında bir segue oluşturarak diğer sayfaya bağladık. Prepare seguesi ile diğer VC'ye verileri gönderdik. Commit fonksiyonu ile tıklanan rowa veri ekleme, silme, animasyon işlemlerini gerçekleştiriyoruz.
        */
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        landmarkNames.append("İstanbul")
        landmarkNames.append("Kremlin")
        landmarkNames.append("Tac Mahal")
        landmarkNames.append("London")
        landmarkNames.append("Stonehenge")
        
        
        landmarkImages.append(UIImage(named: "istanbul.jpeg")!)
        landmarkImages.append(UIImage(named: "london.jpeg")!)
        landmarkImages.append(UIImage(named: "tacmahal.jpeg")!)
        landmarkImages.append(UIImage(named: "london.jpeg")!)
        landmarkImages.append(UIImage(named: "stonehenge.jpeg")!)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarkNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = landmarkNames[indexPath.row] // Row sırası da diziler gibi indexlidir.
        //content.image = landmarkImages[indexPath.row]
        //content.secondaryText = "Second Text"
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenLandmarkName = landmarkNames[indexPath.row]
        chosenLandmarkImage = landmarkImages[indexPath.row]
        performSegue(withIdentifier: "toDetailsVc", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVc"{
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.selectedLandmarkName = chosenLandmarkName
            destinationVC.selectedLandmarkImage = chosenLandmarkImage
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.landmarkNames.remove(at: indexPath.row)
        landmarkImages.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    
    
}

