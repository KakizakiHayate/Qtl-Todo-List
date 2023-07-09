//
//  ImageManaging.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/07/01.
//

import SwiftUI
import FirebaseStorage

final class ImageManager: ObservableObject {
    // MARK: - Property Wrappers
    @Published var isCamera = false
    @Published var isLibrary = false
    // MARK: - Properties
    private let storage = Storage.storage()
    static let shared = ImageManager()
    private init() {}
}

extension ImageManager {
    // MARK: - Methods
    func uploadImage(image: UIImage) async {
        let reference = storage.reference()
        let metadata = StorageMetadata()
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            return
        }
        do {
            let uploadTask = try await reference.putDataAsync(data, metadata: metadata)
            print("Upload Success!")
        } catch {
            fatalError(error.localizedDescription)
        }

    }

    func selectedImagePicker(selectedImageSource: Int) {
        let value = ImageSource(rawValue: selectedImageSource)
        switch value {
        case .camera:
            self.isCamera.toggle()
        case .Library:
            self.isLibrary.toggle()
        default:
            break
        }
    }
}
