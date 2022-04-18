//
//  NoteSettings.swift
//  Notes
//
//  Created by Антон Макаров on 25.03.2022.
//

import UIKit

enum DefaultsKeys: String {
    case title = "Title"
    case description = "Description"
    case date = "Date"
    case array = "Array"
}

final class NoteSettings {
    static let shared = NoteSettings()
    private init() { }
    let defaults = UserDefaults.standard

    func setArray(dictToDo: [String: Any]) {
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

    func getArray() -> [ToDo] {
        var todos = [ToDo]()
        if let array = defaults.array(forKey: DefaultsKeys.array.rawValue) as? [[String: Any]] {
            for dictToDo in array {
                guard let todo = ToDo(dictToDo: dictToDo) else {
                    return []
                }
                todos.append(todo)
            }
            return todos
        } else {
            return []
        }
    }
}
