//
//  UserViewModelOutput.swift
//  ProtocolOrientedUIKit
//
//  Created by Mert ÖZAN on 7.01.2024.
//

import Foundation

// Bu protokol görünümleri güncelleyecek
protocol UserViewModelOutput : AnyObject{
    func updateView(name: String, email: String, userName: String)
}
