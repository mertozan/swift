//
//  ViewController.swift
//  ArtBookProject
//
//  Created by Mert ÖZAN on 9.10.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    // Verileri isim ve id olarak çekiyoruz
    var nameArray = [String]()
    var idArray = [UUID]()
    // Buradan(VC'den) boş giderse add ekranı, dolu giderse bilgi ekranı gösterilecek. VC'de neye tıkladığımızın bilgisini gönderiyoruz
    var selectedPainting = ""
    var selectedPaintingId : UUID?
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView işlemleri
        tableView.delegate = self
        tableView.dataSource = self
        
        //VC'mizin sağ üst köşesine ekleme butonu koymak için navigationController, UIBarButtonItem ile butonumuzu koyduk. Butona tıklandığında DetailsVC seguesini aktifleştirdik.
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        getData()
        
    }
    // Diğer VC'den gelen notu burada yakalıyoruz. ViewdidLoad 1 kere çağrıldığı için yeterli olmaz. viewWillAppear her VC açıldığında çalışan bir fonksiyon. Her VC açıldığında not varsa yakalayacak
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil) // addObserver = Gözlemci ekliyoruz, Mesajı alırsak yapılacak işlemleri fonksiyonda belirtiyoruz. Yani mesajı aldığında getData'yı çalıştıracak ve verileri çekecek.
    }
    
    // Core datadan verilerimizi çektiğimiz fonksiyon
    @objc func getData(){
        
        // Burada verileri birden fazla çektiğinde veriler fazla geliyor. Bu yüzden arrayleri temizleyip öyle getiriyoruz.
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        // Appdelegate ile yazdığımız veriyi de context ile çekiyoruz, appdelegate işlemlerini tekrardan yapıyoruz
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        // Bizim verileri çekmemiz için bir isteğimizi getirmemizi sağlayan bir yapı oluşturmalıyız. Bu yapı fetchRequest
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")    // Paintings'den gelecek verilerin isteğini yaptığımız kısım, bütün Paintings verilerini getiriyor.
        fetchRequest.returnsObjectsAsFaults = false // Catchden okuma işlemleriyle ilgili bir ayar, daha hızlandırıyor, büyük verilerde daha iyi
        
        do{
            let results = try context.fetch(fetchRequest) // Paintings'den gelen veriler dizi olarak gelir ve bunu bir değişkene atıyoruz.
            if results.count > 0{
                for result in results as! [NSManagedObject]{    // result bize any şeklinde bir dizi olarak geliyor. Bunu okuyabilmemiz için NSManagedObject'e casting yapmamız lazım. Bu şekilde result içindeki verilere erişebiliyoruz.
                    if let name = result.value(forKey: "name") as? String{  // Gelen veriyi String olarak cast etmeye çalışıyoruz tekrar
                        self.nameArray.append(name) // Çektiğimiz verileri kullanmak için
                    }
                    
                    if let id = result.value(forKey: "id") as? UUID{
                        self.idArray.append(id)
                    }
                    
                    self.tableView.reloadData() // Yeni bir veri geldiği için TableViewı güncelliyoruz.
                    
                }
            }
            
            
        }catch{
            print("error")
        }
        
        
    }
    
    @objc func addButtonClicked(){
        selectedPainting = ""   // Veri ekleyeceğimizi belirlediğimiz değişken
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    // Buradaki verileri DetailsVC'ye gönderiyoruz
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.chosenPainting = selectedPainting
            destinationVC.chosenPaintingId = selectedPaintingId
        }
    }
    
    // TV içinde veriye tıklandığında segue yapan fonk.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPainting = nameArray[indexPath.row] // Veriye tıklandığını değişkenimize belirtiyoruz. Yani boş değil
        selectedPaintingId = idArray[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }

    // Kullanıcının ne yapacağı işlemleri burada belirliyoruz. Biz sileceğimiz için editingStyle == .delete seçiyoruz.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            // Core datadan verileri bulup sileceğiz, yine appDelegate kullanıyoruz.
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            // FetchRequest oluşturma sebebimiz, veriyi bulup çekeceğiz ve veriyi sileceğiz.
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = idArray[indexPath.row].uuidString    // Tıklanan id'yi belirleyip bir alt satıra bunun bilgisini gönderiyoruz
            // 1 tane veri sileceğimiz için sileceğimiz veriyi belirlemek için predicate kullanıyoruz.
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
                let results = try context.fetch(fetchRequest)
                if results.count > 0{
                    for result in results as! [NSManagedObject]{
                        if let id = result.value(forKey: "id") as? UUID{
                            if id == idArray[indexPath.row]{    // %100 emin olmak için if'e soktuk tekrar.
                                context.delete(result)  // Core datadan verileri sildi
                                nameArray.remove(at: indexPath.row) // TV'deki görünümleri de siliyoruz
                                idArray.remove(at: indexPath.row)   // TV'deki görünümleri de siliyoruz
                                self.tableView.reloadData()
                                
                                do{
                                    try context.save()  // Core datadaki işlemler bittikten sonra kaydediyoruz.
                                }catch{
                                    print("error")
                                }
                                break   // Bunu siktir et önemsiz. For looptan çıkmak için işte
                            }
                        }
                    }
                }
            }catch{
                print("error")
            }
        }
    }
      


}

