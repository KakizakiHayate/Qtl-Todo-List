//
//  TodoView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI

struct TodoListView: View {
    // MARK: - Property Wrappers
    @Binding var todos: [Todos]
    @StateObject private var firebaseManager = FirebaseManager.shared

    // MARK: - body
    var body: some View {
        NavigationStack {
            List {
                TodoListItemView(todos: $todos)
            }.onAppear {
                Task {
                    await firebaseManager.redraw(todos: $todos)
                }
            }
        }
    } // body
} // view

// MARK: - Preview
struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(todos: .constant([]))
    }
}
