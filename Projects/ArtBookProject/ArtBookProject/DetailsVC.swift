//
//  DetailsVC.swift
//  ArtBookProject
//
//  Created by Mert ÖZAN on 9.10.2023.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var artistField: UITextField!
    
    @IBOutlet weak var yearField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    // +'ya tıklandığında verileri girdiğimiz ekran, tableview'a tıkladığımızda verileri gösteren ekranı belirlemek için değişkenler oluşturuyoruz. VC'den boş gelirse add ekranı, dolu gelirse bilgi ekranı gelecek
    var chosenPainting = ""
    var chosenPaintingId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*  - ImageView'ımza tıklanabilir özelliği verdik. Klavyeyi kapatmak için bir GR oluşturduk ve bunu view'a ekledik. Ekranda herhangi bir yer viewdır, tıklanınca klavyenin kapanması için bir hideKeyboard fonksiyonuna view.endEditing vererek bunu sağladık
            - ImageView'ımıza tıklandığında galeri, kamera gibi açılmasını istediğimiz bir GR verdik ve bunu selectImage fonksiyonunda picker ile sağladık. Kullanıcını resmi seçtikten sonra yapılacak işlemleri de yapmamız gereken bir kısım var. didFinishPickingMediaWithInfo = Bu fonk sayesinde görselin UIImage tipinde bir versini döndürecek. Kullanıcının seçeceği tip İmage olacağından UIImage türünden veri gelecek diyoruz ve info[] içerinde image editli mi original vb mi geleceğini seçiyoruz. Sonrasında dismiss ile ekranı kapatıyoruz.
            - saveButtonClicked'ta appDelegatedeki bir fonk ulaşmak için appDelegate'yi bir değişken olarak atıyoruz.
         
         */
        imageView.isUserInteractionEnabled = true
        
        // 
        if chosenPainting != ""{
            // Core Data
            
            saveButton.isHidden = true
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = chosenPaintingId?.uuidString
            
            // Predicate işlemi ile id'si gelen id'nin bilgilerini getirmesini sağlıyoruz. İsme göre isteseydik name = %@, self.chosenPaintingName derdik. Fetch request artık sadece istediğimiz verileri getirmiş olacak. Bütün Paintings verilerini getirmiyor bu sayede.
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject]{    // 1 veri de gelse gelen veriler dizi olarak dönüyor, o yüzden for loopta yapmak iyiymiş. ya da result[0] diyerek alabiliriz.
                        
                        if let name = result.value(forKey: "name") as? String{
                            nameField.text = name
                        }
                        
                        if let artist = result.value(forKey: "artist") as? String{
                            artistField.text = artist
                        }
                        
                        if let year = result.value(forKey: "year") as? Int{
                            yearField.text = String(year)
                        }
                        
                        if let imageData = result.value(forKey: "image") as? Data{  // Data olarak kaydettiğimiz için cast ederek çağırıyoruz
                            let image = UIImage(data: imageData)    // tekrar UIImage'ye çevirdik.
                            imageView.image = image
                        }
                    }
                }
            }catch{
                print("error")
            }
            
            
        }else{
            saveButton.isEnabled = false
            saveButton.isHidden = false
            nameField.text = ""
            artistField.text = ""
            yearField.text = ""
        }
        
        
        
        // Recognizers
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        // ImageView'ı tıklanabilir yapıyoruz ve üstüne tıklama GR oluşturuyoruz
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        

    }
    
    // ImageView tıklandığında olacak işlemler.
    // Picker ile Resimler videolar gibi medya dosyalarını almamızı sağlayan sınıf
    @objc func selectImage(){
        let picker = UIImagePickerController()  // Protokollerini çağırmamız gerek, UIImagePickerControllerDelegate, UINavigationControllerDelegate
        picker.delegate = self  // pickerın fonk çağırmak için delegate ediyoruz
        picker.sourceType = .photoLibrary   // Kamera mı açılacak, galeri mi
        picker.allowsEditing = true          // Image editlenebilir mi
        present(picker, animated: true, completion: nil)    // Pickerı göster
    }
    
    // didFinishPickingMediaWithInfo = Medyayı seçtikten sonra yapılacak işlemlerin sağlandığı fonksiyon
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage  // İstediğimiz medya türünü seçip, UIImage geleceğini bildiğimiz için casting ediyoruz. Bize any veriyor
        saveButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)   // Pickerı kapat
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }    
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        /*  - appDelegate içindeki saveContext func ulaşmak için appDelegate'yi bir dğeişken olarak atıyoruz
            - Sonrasında içnideki fonk kullanmak için context diye bir değişken atıyoruz ve contexte erişiyoruz
            - Core datadaki entityleri kaydeceğimiz contexti veriyoruz. newPainting ile verileri kaydediyoruz(setvalue ile)
            - year = yıl old için Int çeviriyoruz, id = UUID ile kendisi oluşturuyo, image = dataya dönüştürüp sıkıştırma oranını verip o şekilde kaydediyoruz.
            - En son contextimizi kaydetmesini do-try-cath içinde yapıyoruz, çünkü hata verebilir. */
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext   // Appdelegate içindeki fonkları kullanmamızı sağlıyor
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)    // Yeni veerimizi Paintings entity içine context kullanarak veri kaydedeceğiz
        
        // Attributes
        
        newPainting.setValue(nameField.text!, forKey: "name")   // Girilen verileri kaydeetme işlemi
        newPainting.setValue(artistField.text!, forKey: "artist")
        
        if let year = Int(yearField.text!){
            newPainting.setValue(year, forKey: "year")
        }
        
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)   // İmageyi data şeklinde kaydediyoruz ve zipleme oranını belirliyoruz
        newPainting.setValue(data, forKey: "image")
        
        // Hata çıkartabileceği için do try içinde yazarız
        do{
            try context.save()
            print("success")
        }catch{
            print("error")
        }
        
        // Diğer VC'lere mesaj yollamamızı sağlar. Post mesaj göndermemizi sağlıyor. newData mesajını gönderiyoruz. Diğer VC'den bunu yakalayacağız
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)    // Bir önceki VC'ye gitmemizi sağlar
        
    }
    
}
