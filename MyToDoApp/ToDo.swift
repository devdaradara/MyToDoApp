//
//  Car.swift
//  ListNavDemo
//

import SwiftUI

struct ToDo : Codable, Identifiable {
    var id: String
    var title: String
    var isDone: Bool
    
    var category: String
    var categoryImage: String
    
    var description: String
    
    var alertTime: String
    // var pickedImage: Image?
    // Type 'ToDo' does not conform to protocol 'Decodable'/'Encodable'
    // UIImage는 Codable 프로토콜을 따르지 않기 때문 -> 1. url을 받아 String 2. Data로 받기
}
