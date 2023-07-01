//
//  ContentView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI

struct TodoView: View {
    // MARK: - Property Wrappers
    @StateObject private var todoViewModel = TodoViewModel.shared
    @StateObject private var firebaseManager = FirebaseManager.shared

    // MARK: - body
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    TodoListView()
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                firebaseManager.todo = Todos(title: "", message: "")
                                todoViewModel.isTodoAddDetails.toggle()
                            } label: {
                                Image(systemName: "pencil.tip.crop.circle.badge.plus")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                            }.frame(width: 70, height: 70)
                            .background(Color.customColorEmeraldGreen)
                            .cornerRadius(40)
                            .padding()
                            .sheet(isPresented: $todoViewModel.isTodoAddDetails) {
                                AddTodoView(isTodoAddDetails: $todoViewModel.isTodoAddDetails)
                            }
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    } // body
} // view

// MARK: - Preview
struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}
