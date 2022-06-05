//
//  ToDoSettings.swift
//  Notes
//
//  Created by Антон Макаров on 25.03.2022.
//

import UIKit

 private enum DefaultsKeys: String {
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
            indexToDo < array.count ?
            array[indexToDo] = dictToDo :
            array.append(dictToDo)
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
        if array.indices.contains(indexToDo) {
            array.remove(at: indexToDo)
        }
        defaults.setValue(array, forKey: DefaultsKeys.array.rawValue)
    }
}
