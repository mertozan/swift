//
//  PlacesVC.swift
//  FoursquareClone
//
//  Created by Mert ÖZAN on 17.10.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import Lottie


class PlacesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lottieAnimation: LottieAnimationView!
    
    var placeNameArray = [String]()
    var placeIdArray = [String]()
    var selectedPlacedId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lottieAnimation.loopMode = .loop
        lottieAnimation.play()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutButtonClicked))
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFirestore()
    }
    
    func getDataFromFirestore(){
        
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("Places").order(by: "name", descending: true).addSnapshotListener { snapshot, error in
            
            if error != nil{
                print(error?.localizedDescription ?? "Error")
            } else {
                
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    self.placeIdArray.removeAll(keepingCapacity: false)
                    self.placeNameArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents{
                        let placeID = document.documentID
                        self.placeIdArray.append(placeID)
                        if let placeName = document.get("name") as? String{
                            self.placeNameArray.append(placeName)
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        self.lottieAnimation.isHidden = true
                        self.tableView.reloadData()
                    }
                    
                }
                
            }
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destination = segue.destination as! DetailsVC
            destination.chosenPlaceId = selectedPlacedId
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlacedId = placeIdArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArray[indexPath.row]
        return cell
    }
    
    
    @objc func addButtonClicked() {
        self.performSegue(withIdentifier: "toAddPlaces", sender: nil)
    }
    
    @objc func logoutButtonClicked() {
        
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
            
        } catch {
            print("Error")
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        if editingStyle == .delete{
            let firestoreDatabase = Firestore.firestore()
            
            firestoreDatabase.collection("Places").document(placeIdArray[indexPath.row]).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                    
                }
            }
            self.placeNameArray.remove(at: indexPath.row)
            placeIdArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }



}
