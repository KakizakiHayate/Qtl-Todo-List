//
//  LoginViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import FirebaseCore

class LoginViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published var email = "hayate.k.0704@gmail.com"
    @Published var password = "hayate1111"
    // TODO:  ログインできたらtrueにして画面遷移
    @Published var isTodoView = false
}

extension LoginViewModel {
    // MARK: - Methods
    /// メールアドレス/パスワードでログイン
    func login() {
        Task {
            do {
                try await Auth.auth().signIn(withEmail: email, password: password)
                Task.detached { @MainActor in
                    self.isTodoView.toggle()
                }
                print("ログインしました")
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    /// Googleログイン
    func googleLogin() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)

        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let rootViewController = windowScene?.windows.first!.rootViewController!

        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController!) { result, error in
            guard error == nil else {
                print("GIDSignInError: \(error!.localizedDescription)")
                return
            }
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                return
            }
            GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            Task.detached { @MainActor in
                self.isTodoView.toggle()
            }
        }
    }
}
