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
              
                ImageView(selectedToDo: $selectedToDo)
                
                Text(selectedToDo.title)
                    .font(.headline)
                
                Text(selectedToDo.description)
                    .font(.body)
                
                Text(selectedToDo.alertTime)
                
                CompleteSetting(selectedToDo: $selectedToDo)
            }
        }
    }
    
}

struct CarDetail_Previews: PreviewProvider {
    static var previews: some View {
        ToDoDetail(selectedToDo: toDoData[0])
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
                Image(systemName: "plus")
                    .foregroundColor(.blue)
            }).sheet(isPresented: $showingImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { (image) in
                    self.pickedImage = Image(uiImage: image)
                }
            }
            
        }
    }
}
