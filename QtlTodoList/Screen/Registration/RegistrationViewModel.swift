//
//  RegistrationViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import Foundation
import FirebaseAuth

class RegistrationViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published var name = "kakizaki"
    @Published var email = "hayate.k.0704@gmail.com"
    @Published var password = "hayate1111"
    @Published var isTodoView = false
}

extension RegistrationViewModel {
    // MARK: - Methods
    /// 会員登録
    func registration() {
        Task {
            do {
                let result = try await Auth.auth().createUser(withEmail: email,password: password)
                print(email)
                let request = result.user.createProfileChangeRequest()
                request.displayName = name
                try await request.commitChanges()
                try await result.user.sendEmailVerification()
                Task.detached { @MainActor in
                    self.isTodoView.toggle()
                }
            } catch let error {
                // TODO: エラーだった場合は、違うメソッドに飛ばしてエラー表示をScreenにもする
                print(error.localizedDescription)
            }
        }
    }
}
