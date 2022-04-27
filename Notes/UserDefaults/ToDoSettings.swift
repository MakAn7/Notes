//
//  ToDoSettings.swift
//  Notes
//
//  Created by Антон Макаров on 25.03.2022.
//

import UIKit

 private enum DefaultsKeys: String {
    case title = "Title"
    case description = "Description"
    case date = "Date"
    case array = "Array"
}

final class ToDoSettings {
    static let shared = ToDoSettings()
    private init() { }
    let defaults = UserDefaults.standard

    func pushArray(dictToDo: [String: Any]) {
        if var array = defaults.array(forKey: DefaultsKeys.array.rawValue) as? [[String: Any]] {
            array.append(dictToDo)
            defaults.setValue(array, forKey: DefaultsKeys.array.rawValue)
        } else {
            let array: [[String: Any]] = [dictToDo]
            defaults.setValue(array, forKey: DefaultsKeys.array.rawValue)
        }
    }

    func updateToDo(dictToDo: [String: Any], indexToDo: Int) {
        if var array = defaults.array(forKey: DefaultsKeys.array.rawValue) as? [[String: Any]] {
            array[indexToDo] = dictToDo
            defaults.setValue(array, forKey: DefaultsKeys.array.rawValue)
        } else {
            let array: [[String: Any]] = [dictToDo]
            defaults.setValue(array, forKey: DefaultsKeys.array.rawValue)
        }
    }

    func fetchArray() -> [ToDo] {
        var todos = [ToDo]()
        if let array = defaults.array(forKey: DefaultsKeys.array.rawValue) as? [[String: Any]] {
            for dictToDo in array {
                guard let todo = ToDo(dictToDo: dictToDo) else {
                    continue
                }
                todos.append(todo)
            }
            return todos
        } else {
            return []
        }
    }

    func removeToDo (indexToDo: Int) {
        guard var array = defaults.array(forKey: DefaultsKeys.array.rawValue) as? [[String: Any]] else {
            fatalError("Don't fetch array of ToDo")
        }
        array.remove(at: indexToDo)
        defaults.setValue(array, forKey: DefaultsKeys.array.rawValue)
    }
}
