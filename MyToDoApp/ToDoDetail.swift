//
//  CarDetail.swift
//  ListNavDemo
//

import SwiftUI

struct ToDoDetail: View {
    
    @State var selectedToDo: ToDo
    
    var body: some View {
        Form {
            Section(header: Text("Tasks Detail")) {
                
                VStack {
                    Text(selectedToDo.category)
                        .font(.headline)
                    Image(systemName: selectedToDo.categoryImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
                
                Text(selectedToDo.title)
                    .font(.headline)
                
                Text(selectedToDo.description)
                    .font(.body)
                
                HStack {
                    Text("Complete")
                        .font(.body)
                        Spacer()
                    Image(systemName: selectedToDo.isDone ?
                          "checkmark.circle" : "xmark.circle")
                    .foregroundColor(selectedToDo.isDone ? .green : .red)
                    .contextMenu {
                        Button(action: {
                            selectedToDo.isDone = true
                        }) {
                            Text("Mission Complete")
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.green)
                        }
                        
                        Button(action: {
                            selectedToDo.isDone = false
                        }) {
                            Text("Mission Incomplete")
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.red)
                        }
                        
                    }
                }
            }
        }
        .navigationBarItems(trailing: EditButton())
    }
    
}

struct CarDetail_Previews: PreviewProvider {
    static var previews: some View {
        ToDoDetail(selectedToDo: toDoData[0])
    }
}
