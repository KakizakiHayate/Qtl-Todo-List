//
//  AddTodoView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI

struct AddTodoView: View {
    // MARK: - Property Wrappers
    @State private var title = ""
    @State private var message = ""
    @Binding var isTodoAddDetails: Bool
    @StateObject private var todoListViewModel = TodoListViewModel.shared
    // MARK: - body
    var body: some View {
        ScrollView {
            VStack {
                TextField("入力", text: $title)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextEditor(text: $message)
                    .frame(height: 250)
                    .border(.gray, width: 2)
                    .padding()
                Button {
                    if !title.isEmpty || !message.isEmpty {
                        self.todoListViewModel.createFirestoreData(title: title, message: message)
                    }
                    self.isTodoAddDetails.toggle()
                } label: {
                    Text("完了")
                }
                .padding()
            }
        }
    } // body
} // view

// MARK: - Preview
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView(isTodoAddDetails: .constant(false))
    }
}
