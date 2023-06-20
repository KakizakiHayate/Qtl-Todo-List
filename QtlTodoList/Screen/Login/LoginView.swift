//
//  LoginView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI

struct LoginView: View {
    // MARK: - Property Wrappers
    @StateObject private var loginViewModel = LoginViewModel()
    @State private var isRegistrationView = false
    // MARK: - body
    var body: some View {
        NavigationStack {
            VStack {
                TextField("メールアドレスを入力", text: $loginViewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextField("パスワードを入力", text: $loginViewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button {
                    loginViewModel.login()
                } label: {
                    Text("ログインする")
                }.padding()
                Button {
                    loginViewModel.googleLogin()
                } label: {
                    Text("Googleログイン")
                }.padding()
                Button {
                    isRegistrationView.toggle()
                } label: {
                    Text("新規登録はコチラ")
                }.padding()
            }
            .navigationDestination(isPresented: $loginViewModel.isTodoView) {
                TodoView()
            }
            .navigationDestination(isPresented: $isRegistrationView) {
                RegistrationView()
            }
        }
    } // body
} // view

// MARK: - Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
