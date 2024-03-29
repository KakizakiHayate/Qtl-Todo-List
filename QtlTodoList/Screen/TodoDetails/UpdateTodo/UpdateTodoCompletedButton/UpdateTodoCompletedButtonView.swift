//
//  UpdateTodoCompletedButtonView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/08/25.
//

import SwiftUI

struct UpdateTodoCompletedButtonView: View {
    // MARK: - Property Wrappers
    @Binding var todos: Todos
    @Binding var todoImage: UIImage
    @Binding var isTextEmpty: Bool
    @StateObject private var firebaseManager = FirebaseManager.shared
    @Environment(\.dismiss) private var dismiss
    // MARK: - Properties
    private let proxyWidth: CGFloat
    // MARK: - init
    init(
        todos: Binding<Todos>,
        todoImage: Binding<UIImage>,
        isTextEmpty: Binding<Bool>,
        proxyWidth: CGFloat
    ) {
        self._todos = todos
        self._todoImage = todoImage
        self._isTextEmpty = isTextEmpty
        self.proxyWidth = proxyWidth
    }

    // MARK: - body
    var body: some View {
        Button {
            if !todos.title.isEmpty && !todos.message.isEmpty {
                Task {
                    let uploadUrl = await firebaseManager.todoImageUpload(image: todoImage)
                    await firebaseManager.updateFirestoreData(todo: todos, uploadUrl: uploadUrl)
                    dismiss()
                }
            } else {
                isTextEmpty.toggle()
            }
        } label: {
            Text(AppConst.Text.completed)
                .foregroundColor(.white)
                .bold()
                .frame(width: proxyWidth / 4)
        }.padding()
            .background(Color.customColorEmeraldGreen)
            .cornerRadius(40)
    } // body
} // view

// MARK: - Preview
struct UpdateTodoCompletedButtonView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTodoCompletedButtonView(todos: .constant(Todos(title: "", message: "", uploadUrl: "")),
                                      todoImage: .constant(UIImage()),
                                      isTextEmpty: .constant(false),
                                      proxyWidth: 0)
    }
}
