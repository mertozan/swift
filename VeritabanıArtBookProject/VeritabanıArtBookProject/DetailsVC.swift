//
//  DetailsVC.swift
//  VeritabanıArtBookProject
//
//  Created by Mert ÖZAN on 12.05.2023.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var namText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Recognizers
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        view.addGestureRecognizer(imageTapRecognizer)
        
    }
    
    // Burada galeriden resim seçtirme işlemini yapıyoruz fakat seçtikten sonra ne olacağı aşağıdaki fonkda yapıyoruz
    @objc func selectImage(){
        let picker = UIImagePickerController() // Bunu kullanabilmemiz için için protokolleri çağırmamız gerekir. UIImagePickerControllerDelegate, UINavigationControllerDelegate
        picker.delegate = self
        picker.sourceType = .photoLibrary // Resim için nereyi açacağız.
        picker.allowsEditing = true // Kullanıcı kullanacağı resmi editleyebilir
        present(picker, animated: true) //
    }
    
    // Bu fonksiyon medyayı seçtikten sonra ne olacağını ayarladığımız kısım
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage // Orijinal resim
        self.dismiss(animated: true) // Açtığımız pickerı kapatıyoruz.
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate  // Appdelegateyi buraya değişken olarak tanımlamış oluyoruz.
        let context = appDelegate.persistentContainer.viewContext
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        // Attributes
        
        newPainting.setValue(namText.text!, forKey: "name")
        newPainting.setValue(artistText.text!, forKey: "artist")
        newPainting.setValue(NSUUID(), forKey: "id")
        
        if let year = Int(yearText.text!){
            newPainting.setValue(year, forKey: "year")
        }
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("success")
        }catch{
            print("error")
        }
        
        
        
        // context.save() // Core dataya veri kaydetmemizi sağlar
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true) // Klavyeyei kapatır
    }
    
}
