//
//  QtlTodoListApp.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
@main
struct QtlTodoListApp: App {
    // MARK: - Property Wrapper
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    // MARK: - body
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    } // body
} // app
