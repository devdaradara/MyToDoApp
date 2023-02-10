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
}
