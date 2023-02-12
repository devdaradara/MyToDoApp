//
//  AddNewCar.swift
//  ListNavDemo
//

import SwiftUI

struct AddNewToDo: View {
    
    @ObservedObject var toDoStore: ToDoStore
    
    @State var isDone = false
    @State var title: String = ""
    @State var category: String = ""
    @State var categoryImage: String = ""
    @State var description: String = ""
    @State var date: Date = Date()
    
    var body: some View {
        Form {
            Section(header: Text("Add To Do")) {
                DataInput(title:"Task Title", userInput: $title)
                DataInput(title: "Description", userInput: $description)
                
                PickerCategory(category: $category)
                
                PickerDate(date: $date)
            }
            
            Button(action: addNewToDo) {
                Text("Add Tasks")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    func addNewToDo() {
        let newToDo = ToDo(id: UUID().uuidString, title: title, isDone: isDone, category: category, categoryImage: selectImage(), description: description, alertTime: dateToString(date: date))
                
        toDoStore.toDos.append(newToDo)
    }
    
    func selectImage() -> String {
        var categoryImages = ""
        if category == "Study" {
            categoryImages = "books.vertical"
        } else if category == "Game" {
            categoryImages = "gamecontroller"
        } else if category == "Coding" {
            categoryImages = "desktopcomputer.trianglebadge.exclamationmark"
        } else if category == "Promise" {
            categoryImages = "person.3"
        }
        return categoryImages
    }
    
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}

struct DataInput: View {
    
    var title: String
    @Binding var userInput: String
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            Text(title)
                .font(.headline)
            TextField("Enter \(title)", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
    
}

struct PickerCategory: View {
    
    @Binding var category: String
    let categoryNames = ["Study","Coding", "Game", "Promise"]
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            Text("Category")
                .font(.headline)
                .multilineTextAlignment(.leading)
            
            Picker(selection: $category,
                   label: Text("picker"),
                   content: {
                    ForEach(categoryNames.indices) { index in
                        Text(categoryNames[index])
                            .tag(categoryNames[index])
                    }
            })
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
    }
    
}

struct PickerDate: View {
    
    @Binding var date: Date
    
    var body: some View {
        VStack {
            Text("Date")
                .font(.headline)
                .multilineTextAlignment(.leading)
            DatePicker("Date", selection: $date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .frame(maxHeight: 400)
        }
        .padding()
    }
}

