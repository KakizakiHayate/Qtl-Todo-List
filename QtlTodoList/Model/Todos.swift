//
//  Todos.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import Foundation

struct Todos: Identifiable {
    // MARK: - Properties
    var id = UUID().uuidString
    var title: String
    var message: String
}
