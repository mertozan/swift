//
//  ViewController.swift
//  TravelBook
//
//  Created by Mert ÖZAN on 10.10.2023.
//

import UIKit
import MapKit       // Map işlemleri
import CoreLocation // Konum işlemleri
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var commentText: UITextField!
    
    var locationManager = CLLocationManager() // Kullanıcının konumu ile ilgili işlemler yapacaksak bunu kullanmamız gerekiyor
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    var selectedTitle = ""
    var selectedTitleID : UUID?
    
    var annotationTitle = ""
    var annotationSubtitle = ""
    var annotationLatitude = Double()
    var annotationLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest   // Kullanıcının location keskinliği, sapma payı. En iyisi daha fazla pil harcar.
        locationManager.requestWhenInUseAuthorization() // Kullanıcınında izin istiyoruz, her zaman-uyg kullanıldığında gibi
        locationManager.startUpdatingLocation() // Kullanıcının yerini almaya başlıyoruz. info'dan kullanıcıya izin açıklaması yazıyoruz
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))   // Uzun basma GR'si
        gestureRecognizer.minimumPressDuration = 1.5  // Kaç sn basıldığında algılanacak
        mapView.addGestureRecognizer(gestureRecognizer)
        
        if selectedTitle != ""{
            // Core data
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            let idString = selectedTitleID!.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
                let results = try context.fetch(fetchRequest)
                if results.count > 0{
                    
                    for result in results as! [NSManagedObject]{
                        // Burada iç içe almamız tek bir veri seti geleceğinden
                        if let title = result.value(forKey: "title") as? String{
                            annotationTitle = title
                            
                            if let subtitle = result.value(forKey: "subtittle") as? String{
                                annotationSubtitle = subtitle
                                
                                if let latitude = result.value(forKey: "latitude") as? Double{
                                    annotationLatitude = latitude
                                    
                                    if let longitude = result.value(forKey: "longitude") as? Double{
                                        annotationLongitude = longitude
                                        
                                        let annotation = MKPointAnnotation()
                                        annotation.title = annotationTitle
                                        annotation.subtitle = annotationSubtitle
                                        let coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongitude)
                                        annotation.coordinate = coordinate
                                        
                                        mapView.addAnnotation(annotation)
                                        nameText.text = annotationTitle
                                        commentText.text = annotationSubtitle
                                        
                                        locationManager.stopUpdatingLocation()
                                        
                                        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                        let region = MKCoordinateRegion(center: coordinate, span: span)
                                        mapView.setRegion(region, animated: true)
                                        
                                        
                                    }
                                }
                            }
                        }
                    }
                }
                
            }catch{
                print("Error")
            }
        }else {
            // Add new data
        }
        
    }
    
    @objc func chooseLocation(gestureRecognizer:UILongPressGestureRecognizer){  // Buraya GR değişken ismi yazıyoruz ve aşağıda GR'nin durumlarına erişebiliyoruz
        
        if gestureRecognizer.state == .began{    // GR başladıysa ...
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView) // Tıklanan noktayı koordinata çeviriyor.
            
            chosenLatitude = touchedCoordinates.latitude
            chosenLongitude = touchedCoordinates.longitude
            
            let annotation = MKPointAnnotation()    // Annotationumuz mapte tıklandığında üstünde çıkacak baloncuk
            annotation.coordinate = touchedCoordinates  // Annottationa coordinatları verdik
            annotation.title = nameText.text    // Başlığı
            annotation.subtitle = commentText.text
            self.mapView.addAnnotation(annotation)  // Mapviewa ekliyoruz
        }
        
    }
    
    // Güncellenenen lokasyonları dizi olarak verir. locations seçtiğimizde bize CLLocation objesi verir. Bu obje enlem ve boylam bilgisi içerir
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if selectedTitle == ""{
            let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.latitude)  // locations'a gelen konumunun enlem boylamını yazarız.
            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)    // Zoomlama, ne kadar küçükse o kadar zoomlar
            let region = MKCoordinateRegion(center: location, span: span)   // Nereyi merkez alsın ve zoom oranı
            mapView.setRegion(region, animated: true)   // Belirtilen enlem ve boylama zoomlayacak
        }else {
            //
        }
        
    }
    
    // Annotationview oluşturuyor, kod koymazsak default. Annotationview oluşturuyoruz
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // MKUserLocation = Kullanıcının yerini bir pinle gösteren annotation. Pinle göstermiyoruz
        if annotation is MKUserLocation{
            return nil
        }
        
        let reusedId = "myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reusedId) as? MKMarkerAnnotationView
        // PinView oluşturulmadıysa oluşturuyoruz.
        if pinView == nil{
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reusedId)
            pinView?.canShowCallout = true  // Baloncukla beraber ekstra bilgi gösterdiğimiz yer
            pinView?.tintColor = UIColor.black  // Annotationların rengi
            
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)   // deatilsDsiclosure = Detay gösteren bir buton.
            pinView?.rightCalloutAccessoryView = button // Sağ tarafında gösterilecek görünümde button'u göster diyoruz.
            
        }else{
            pinView?.annotation = annotation
        }
        
        return pinView
        
    }
    
    // calloutAccessoryControlTapped = Pinde gösterilen info'ya tıklandığında yapılacak işlemleri yapan fonk.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if selectedTitle != ""{
            let requestLocation = CLLocation(latitude: annotationLatitude, longitude: annotationLongitude)
            // CLGeocoder() = Koordinatlar ve yerler arasında bağlantu kurmamızı sağlayan sınıf,
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarks, error in
                // closure, Bir işlem yapıyoruz bunun sonucunda bize bir şey verecek. placemark bulunan bir array verecek ya da error verecek.
                
                if let placemark = placemarks{
                    if placemark.count > 0{
                        let newPlacemark = MKPlacemark(placemark: placemark[0]) //  MKPlacemark objesine ihtiyacımız var
                        let item = MKMapItem(placemark: newPlacemark)   // Navigasyon açabilmeiz için için MapItem oluşturmamız gerekiyor. MapItem oluşturabilmek için placemark objesi gerekiyor. Bunu da reverseGeocodeLocation metodla alabiliyoruz.
                        item.name = self.annotationTitle
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]    // Hangi şekilde açılsın maps, burada araçla gideceğiz araçla aç diyoruz.
                        item.openInMaps(launchOptions: launchOptions)   // item ile navigasyonu açıyoruz,
                    }
                }
  
            }
        }
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        
        newPlace.setValue(nameText.text, forKey: "title")
        newPlace.setValue(commentText.text, forKey: "subtittle")
        newPlace.setValue(chosenLatitude, forKey: "latitude")
        newPlace.setValue(chosenLongitude, forKey: "longitude")
        newPlace.setValue(UUID(), forKey: "id")
        
        do{
            try context.save()
            print("success")
        }catch{
            print("error")
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPlace"), object: nil)
        navigationController?.popViewController(animated: true)
        
        
    }
    


}

