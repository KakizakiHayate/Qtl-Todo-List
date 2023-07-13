//
//  QtlTodoListApp.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI
import FirebaseCore

@main
struct QtlTodoListApp: App {
    // MARK: - init
    init() {
        FirebaseApp.configure()
    }
    // MARK: - body
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    } // body
} // app
