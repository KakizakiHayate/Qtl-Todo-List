//
//  firebaseManager.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

final class FirebaseManager: ObservableObject {
    // MARK: - Property Wrappers
    @Published var todos = [Todos]()
    @Published var todo = Todos(title: "", message: "")
    // MARK: - Properties
    static let shared = FirebaseManager()
    private static let firestore = Firestore.firestore()
    private let storage = Storage.storage()
}

extension FirebaseManager {
    // MARK: - Methods
    /// Firestoreにデータ追加
    func createFirestoreData(title: String, message: String, imageURL: String?) {
        let imageURL = imageURL ?? ""
        let todos = Todos(title: "", message: "")
        Task {
            try await FirebaseManager.firestore.collection("todos").document(todos.id).setData([
                "title": title,
                "message": message,
                "imageURL": imageURL
            ])
        }
    }

    /// Firestoreのデータ読み込み
    func readFirestoreData() {
        FirebaseManager.firestore.collection("todos").addSnapshotListener { querySnapshot, error in
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
            try await FirebaseManager.firestore.collection("todos").document(todo.id).setData([
                "title": todo.title,
                "message": todo.message
            ])
        }
    }

    /// Firestoreのデータ削除
    func deleteFirestoreData(todo: Todos) {
        Task {
            try await FirebaseManager.firestore.collection("todos").document(todo.id).delete()
        }
    }

    /// cloud storageにアップロード
    func uploadImage(image: UIImage) async -> String? {
        let reference = storage.reference()
        let imageReference = reference.child("image/\(UUID().uuidString).jpeg")
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            return nil
        }
        do {
            let uploadTask = try await imageReference.putDataAsync(data)
            print("Upload Success!")
            let downloadURL = try? await imageReference.downloadURL()
            return downloadURL?.absoluteString
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
