//
//  ContentView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI

struct TodoView: View {
    // MARK: - Property Wrappers
    @State private var isTodoAddDetails = false
    @StateObject var todoViewModel = TodoViewModel.shared
    @StateObject var todoListViewModel = TodoListViewModel.shared
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
                                self.todoViewModel.todo = Todos(title: "", message: "")
                                self.isTodoAddDetails.toggle()
                            } label: {
                                Image(systemName: "pencil.tip.crop.circle.badge.plus")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                            }
                            .frame(width: 70, height: 70)
                            .background(Color.customColorEmeraldGreen)
                            .cornerRadius(40)
                            .padding()
                            .sheet(isPresented: $isTodoAddDetails) {
                                AddTodoView(isTodoAddDetails: $isTodoAddDetails)
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
