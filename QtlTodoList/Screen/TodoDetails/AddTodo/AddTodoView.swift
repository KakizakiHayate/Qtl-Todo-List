//
//  AddTodoView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI

struct AddTodoView: View {
    // MARK: - Property Wrappers
    @State private var selectedImageSource = 0
    @Binding var isTodoAddDetails: Bool
    @StateObject private var firebaseManager = FirebaseManager.shared
    @StateObject private var addTodoViewModel = AddTodoViewModel()

    // MARK: - body
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    Spacer()
                        .frame(height: proxy.size.height * 0.08)
                    if addTodoViewModel.isTextEmpty {
                        HStack {
                            Text("タイトル又はメッセージが未入力です")
                                .foregroundColor(.red)
                                .padding(.leading)
                            Spacer()
                        }
                    }
                    TextField("タイトルが入力", text: $addTodoViewModel.title)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(addTodoViewModel.isTextEmpty ? Color.red : Color.gray, lineWidth: 1)
                        )
                        .padding(.top, 0)
                        .padding(.horizontal)
                    ZStack {
                        TextEditor(text: $addTodoViewModel.message)
                            .frame(height: proxy.size.height / 3)
                            .border(addTodoViewModel.isTextEmpty ? .red : .gray, width: 1)
                            .padding()
                        if addTodoViewModel.message.isEmpty {
                            VStack {
                                HStack {
                                    Text("メッセージを入力")
                                        .opacity(0.25)
                                        .padding()
                                    Spacer()
                                }.padding(.leading, 4)
                                    .padding(.top, 10)
                                Spacer()
                            }
                        }
                    }
                    Image(uiImage: addTodoViewModel.image)
                        .resizable()
                        .padding()
                        .frame(width: 100, height: 100)
                    Picker("画像選択", selection: $selectedImageSource) {
                        Text("カメラを起動").tag(1)
                        Text("ライブラリーから選択").tag(2)
                    }.padding()
                        .onChange(of: selectedImageSource) { newValue in
                            addTodoViewModel.selectedImagePicker(selectedImageSource: newValue)
                            //selectedImageSource = 0
                        }
                        .sheet(isPresented: $addTodoViewModel.isCamera) {
                            CameraController(image: $addTodoViewModel.image,
                                             isActivateCameraView: $addTodoViewModel.isCamera)
                        }
                        .sheet(isPresented: $addTodoViewModel.isLibrary) {
                            SelectionGallery(image: $addTodoViewModel.image,
                                             isSelectionGalleryView: $addTodoViewModel.isLibrary)
                        }
                    Button {
                        if !addTodoViewModel.title.isEmpty && !addTodoViewModel.message.isEmpty {
                            Task {
                                addTodoViewModel.imageURL = await firebaseManager.uploadImage(image: addTodoViewModel.image)
                                firebaseManager.createFirestoreData(
                                    title: addTodoViewModel.title,
                                    message: addTodoViewModel.message,
                                    imageURL: addTodoViewModel.imageURL)
                                isTodoAddDetails.toggle()
                                addTodoViewModel.title = ""
                                addTodoViewModel.message = ""
                                addTodoViewModel.image = UIImage()
                            }
                        } else {
                            addTodoViewModel.isTextEmpty = true
                        }
                    } label: {
                        Text("完了")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: proxy.size.width / 4)
                    }.padding()
                        .background(Color.customColorEmeraldGreen)
                        .cornerRadius(40)
                }
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
