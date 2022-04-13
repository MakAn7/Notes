//
//  Note.swift
//  Notes
//
//  Created by Антон Макаров on 01.04.2022.
//

import Foundation

struct ToDo {
    let title: String
    let description: String
    let date: String?

    var isEmpty: Bool {
        if title.isEmpty && description.isEmpty {
            return true
        } else {
            return false
        }
    }

    var dictionaryOfToDo: [String: Any] {
        var dictToDo: [String: Any] = [:]
        dictToDo["title"] = title
        dictToDo["description"] = description
        dictToDo["date"] = date
        return dictToDo
    }
    init(title: String, description: String, date: String?) {
        self.title = title
        self.description = description
        self.date = date
    }

    init?(dictToDo: [String: Any]) {
        guard let title = dictToDo["title"] as? String,
              let description = dictToDo["description"] as? String,
              let date = dictToDo["date"] as? String else {
            return nil
        }
        self.title = title
        self.description = description
        self.date = date
    }
}
