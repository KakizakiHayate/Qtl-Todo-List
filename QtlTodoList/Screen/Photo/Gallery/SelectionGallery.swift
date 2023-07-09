//
//  SelectionGallery.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/07/01.
//

import SwiftUI
import PhotosUI

struct SelectionGallery: UIViewControllerRepresentable {
    // TODO: markコメントとextensionしてない
    @Binding var image: UIImage
    @Binding var isSelectionGalleryView: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<SelectionGallery>) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()

        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: UIViewControllerRepresentableContext<SelectionGallery>) {

    }

    class Coordinator: NSObject, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
        let parent: SelectionGallery
        init(parent: SelectionGallery) {
            self.parent = parent
        }

        /// 写真を選択したとき
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            print("picker")
            self.parent.isSelectionGalleryView = false

            if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                    guard let image = image as? UIImage else {
                        return
                    }
                    DispatchQueue.main.async {
                        self?.parent.image = image
                    }
                }
            }
        }
    }
}
