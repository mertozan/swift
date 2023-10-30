//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by Mert ÖZAN on 18.10.2023.
//

import Foundation
import UIKit

class PlaceModel{
    
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    
    private init(){}    // Başka hiçbir yerden initializing işlemi yapılmamasını sağlar
    
}
