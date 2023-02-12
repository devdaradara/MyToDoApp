//
//  CarDetail.swift
//  ListNavDemo
//

import SwiftUI

struct ToDoDetail: View {
    
    @State var selectedToDo: ToDo
    @State var isEditMode = false // Add edit mode state
    
    var body: some View {
        Form {
            Section(header: Text("Tasks Detail")) {
              
                ImageView(selectedToDo: $selectedToDo)
                
                Text(selectedToDo.title)
                    .font(.headline)
                
                Text(selectedToDo.description)
                    .font(.body)
                
                Text(selectedToDo.alertTime)
                
                CompleteSetting(selectedToDo: $selectedToDo)
                
                Button(action: {
                    self.isEditMode = true
                }) {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $isEditMode) {
            ToDoEdit(selectedToDo: $selectedToDo, isPresented: $isEditMode)
        }
    }
    
}

struct ImageView: View {
    
    @Binding var selectedToDo: ToDo
    @State private var showingImagePicker = false
    @State var pickedImage: Image?
    
    var body: some View {
        
        VStack {
            Text(selectedToDo.category)
                .font(.headline)
            
            if selectedToDo.isDone {
                pickedImage?.resizable()
                    .frame(height:300)
                    .clipped()
            } else {
                Image(systemName: selectedToDo.categoryImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }
            
            Button(action: {
                self.showingImagePicker.toggle()
            }, label: {
                Text("Done")
                    .foregroundColor(.blue)
            }).sheet(isPresented: $showingImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { (image) in
                    self.pickedImage = Image(uiImage: image)
                }
            }
        }
    }
}

struct CompleteSetting: View {
    
    @Binding var selectedToDo: ToDo
    
    var body: some View {
        HStack {
            Text("Complete")
                .font(.body)
            Spacer()
            Image(systemName: selectedToDo.isDone ? "checkmark.circle" : "xmark.circle")
                .foregroundColor(selectedToDo.isDone ? .green : .red)
                .contextMenu {
                    Button(action: {
                        selectedToDo.isDone = true
                    }) {
                        Text("Mission Complete 👍")
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                    }
                    
                    Button(action: {
                        selectedToDo.isDone = false
                    }) {
                        Text("Mission Incomplete 👊")
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.red)
                    }
                    
                }
        }
    }
}


//Trailing closure passed to parameter of type 'FormStyleConfiguration' that does not accept a closure
// iOS 15에서는 Form의 생성자에 trailing closure를 전달할 수 없어 생기는 문제
struct ToDoEdit: View {
    
    @Binding var selectedToDo: ToDo
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            
            Form {
                Group {
                    Section(header: Text("Tasks Detail")) {
                        ImageView(selectedToDo: $selectedToDo)
                        TextField("Title", text: $selectedToDo.title)
                        TextField("Description", text: $selectedToDo.description)
                        DatePicker("Alert Time", selection: Binding(
                            get: { stringToDate(selectedToDo.alertTime) },
                            set: { selectedToDo.alertTime = dateToString($0) }
                        ), displayedComponents: .date)
                    }
                
                    Section {
                        Button(action: {
                            self.isPresented = false
                        }) {
                            Text("Save")
                        }
                    }
                }
            }
            .navigationTitle("Edit Task")
        }
    }
    
    func stringToDate(_ date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.date(from: date)!
    }
    
    func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: date)
    }
    
}
