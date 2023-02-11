//
//  ContentView.swift
//  ListNavDemo
//
//  Created by 류지예 on 2023/02/09.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var toDoStore: ToDoStore = ToDoStore(toDos: toDoData)
    @State var toggleStatus = true
    
    var body: some View {
        
        NavigationView {
            List {
                Section(header: Text("Settings")
                    .fontWeight(.bold)
                ) {
                    Toggle(isOn: $toggleStatus) {
                        Text("Allow Notifications")
                    }
                }
                
                Section(header: Text("To Do Tasks")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                ) {
                    ForEach (toDoStore.toDos) { todo in
                        ShowToDoList(todo: todo)
                    }
                    .onDelete(perform: deleteItems)
                    .onMove(perform: moveItems)
                }
            }
            .navigationBarTitle(Text("To Do List"))
            .navigationBarItems(leading: NavigationLink(destination: AddNewToDo(toDoStore: self.toDoStore)) {
                Text("Add")
                    .foregroundColor(.blue)
            }, trailing: EditButton())
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        toDoStore.toDos.remove(atOffsets: offsets)
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        toDoStore.toDos.move(fromOffsets: source, toOffset: destination)
    }
}


struct ShowToDoList: View {
    
    var todo: ToDo
    
    var body: some View {
        NavigationLink(destination: ToDoDetail(selectedToDo: todo))  {
            HStack {
                Image(systemName: todo.categoryImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 18)
                Text(todo.title)
            }
        }
    }
}
