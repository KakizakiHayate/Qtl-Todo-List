//
//  TodoView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI

struct TodoListView: View {
    // MARK: - Property Wrappers
    @ObservedObject private var todoListViewModel = TodoListViewModel.shared
    @ObservedObject private var todoViewModel = TodoViewModel.shared
    @State private var isTodoUpdateDetails = false
    // MARK: - body
    var body: some View {
        List {
            ForEach(todoListViewModel.todos) { todo in
                VStack(alignment: .leading) {
                    HStack {
                        Text(todo.title)
                        Spacer()
                        Image(systemName: "pencil")
                            .foregroundColor(.customColorEmeraldGreen)
                            .font(.title)
                            .onTapGesture {
                                self.todoViewModel.todo = todo
                                self.isTodoUpdateDetails.toggle()
                            }
                            .navigationDestination(isPresented: $isTodoUpdateDetails) {
                                UpdateTodoView(isTodoUpdateDetails: $isTodoUpdateDetails)
                            }
                            .padding(.trailing)
                        Image(systemName: "trash")
                            .foregroundColor(.customColorEmeraldGreen)
                            .font(.title2)
                            .onTapGesture { todoListViewModel.deleteFirestoreData(todo: todo) }
                    }.padding(.bottom)
                    Text(todo.message)
                }
            }
        }
        .onAppear {
            todoListViewModel.readFirestoreData()
        }
    } // body
} // view

// MARK: - Preview
struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
