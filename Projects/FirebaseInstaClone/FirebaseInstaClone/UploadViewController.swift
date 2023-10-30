//
//  UploadViewController.swift
//  FirebaseInstaClone
//
//  Created by Mert ÖZAN on 12.10.2023.
//

import UIKit
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    @IBOutlet weak var commentText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)

        
    }
    
    @objc func chooseImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    

    @IBAction func actionButtonClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()  // Bu referansı kullanarak hangi klasörde çalışacağımızı nereye kaydedeceğimizi belirtliyoruz.
        
        // mediaFolder = Klasörün referansı
        let mediaFolder = storageReference.child("media")   // Storagemizde media varsa içine girer, yoksa otomatik oluşturur. storageReference.child("media").child("....") olarak alt klasörlere de devam edebiliriz.
        
        // Kaydetme, görseli alıp veriye çevirip firebaseye data olarak kaydedebiliriz.
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString    // Resime belirli bir isim verdiğimizde her kaydetmede yeni resim öncekinin üstüne kaydedilir. O yüzden rastgele bir id oluşturup aşağıdaki gibi her resime farklı isim ile kayıt yapıyoruz.
            
            let imageReference = mediaFolder.child("\(uuid).jpg") // imageReference = Görselin referansı.
            imageReference.putData(data, metadata: nil) { metadata, error in
                if error != nil{
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    // Kullanıcının metadatasını kullanarak kullanıcının kaydettiği şeyin hangi URL'ye kaydedildiğini alıyoruz. downloadURL = url veya hata döndürür
                    imageReference.downloadURL { url, error in
                        
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString // absoluteString = URL'yi al stringe çevir, imagemizi almış olduk
                            // print(imageUrl)  // Resmin urlsi konsolda çıkıyor, webe yazıp indirebiliriz
                            
                            // DATABASE
                            
                            let firestoreDatabase = Firestore.firestore()  //
                            
                            var firestoreReference : DocumentReference? = nil  // Firestore databasesini okumak, yazmak, değişiklikleri dinlemek için kullandığımız bir obje
                            
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.commentText.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
                            
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                
                                if error != nil{
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                } else {
                                    
                                    self.imageView.image = UIImage(named: "select.png")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0    // Tab barın selected index aşağıdaki barların indexleri, 0 = feed, 1 = upload, 2 = settings
                                    
                                }
                                
                            })
                            
                        }
                        
                    }
                    
                }
            }
            
            
        }
        
    }

}
