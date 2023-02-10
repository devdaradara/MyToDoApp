//
//  CarStore.swift
//  ListNavDemo
//

import SwiftUI
import Combine

class ToDoStore : ObservableObject {
    
    @Published var toDos: [ToDo]
    
    init(toDos: [ToDo] = []) {
        self.toDos = toDos
    }
}
