//
//  RegistrationView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI

struct RegistrationView: View {
    // MARK: - Property Wrappers
    @StateObject private var registrationViewModel = RegistrationViewModel()
    // MARK: - body
    var body: some View {
        NavigationStack {
            VStack {
                TextField("名前を入力", text: $registrationViewModel.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextField("メールアドレスを入力", text: $registrationViewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextField("パスワードを入力", text: $registrationViewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button {
                    registrationViewModel.registration()
                    print("sss")
                } label: {
                    Text(AppConst.Text.registration)
                }
                .padding()
            }
            .navigationDestination(isPresented: $registrationViewModel.isTodoView) {
                TodoView()
            }
        }
    } // body
} // view

// MARK: - Preview
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
