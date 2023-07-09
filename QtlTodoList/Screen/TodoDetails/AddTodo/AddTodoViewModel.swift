//
//  UpdateTodoViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/24.
//

import SwiftUI

class AddTodoViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published var title = ""
    @Published var message = ""
    @Published var isTextEmpty = false
    @Published var isCamera = false
    @Published var isLibrary = false
    @Published var image = UIImage()
    @Published var imageURL: String?
}

extension AddTodoViewModel {
    // MARK: - Methods
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
