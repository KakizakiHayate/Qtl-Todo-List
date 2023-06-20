//
//  TodoViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import Foundation
import FirebaseFirestore

class TodoListViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published var todos = [Todos]()
    // MARK: - Properties
    private let firestore = Firestore.firestore()
    static let shared = TodoListViewModel()
}

extension TodoListViewModel {
    // MARK: - Methods
    /// Firestoreにデータ追加
    func createFirestoreData(title: String, message: String) {
        let todos = Todos(title: "", message: "")
        Task {
            try await firestore.collection("todos").document(todos.id).setData([
                "title": title,
                "message": message
            ])
        }
    }

    /// Firestoreのデータ読み込み
    func readFirestoreData() {
         firestore.collection("todos").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("error: \(error.debugDescription)")
                return
            }
            self.todos = documents.map { querySnapshot -> Todos in
                let data = querySnapshot.data()
                let title = data["title"] as? String ?? ""
                let message = data["message"] as? String ?? ""

                return Todos(id: querySnapshot.documentID, title: title, message: message)
            }
         }
    }

    /// FireStoreのデータ更新
    func updateFirestoreData(todo: Todos) {
        Task {
            try await firestore.collection("todos").document(todo.id).setData([
                "title": todo.title,
                "message": todo.message
            ])
        }
    }

    /// Firestoreのデータ削除
    func deleteFirestoreData(todo: Todos) {
        Task {
            try await firestore.collection("todos").document(todo.id).delete()
        }
    }
} // extension
