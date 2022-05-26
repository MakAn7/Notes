//
//  Note.swift
//  Notes
//
//  Created by Антон Макаров on 01.04.2022.
//

import Foundation

struct ToDo: Decodable {
    let title: String
    let description: String
    let date: Date?

    var isEmpty: Bool {
        if title.isEmpty && description.isEmpty {
            return true
        }
            return false
        }

    enum CodingKeys: String, CodingKey {
        case title = "header"
        case description = "text"
        case date
    }

    var dictionaryOfToDo: [String: Any] {
        var dictToDo: [String: Any] = [:]
        dictToDo["title"] = title
        dictToDo["description"] = description
        dictToDo["date"] = date
        return dictToDo
    }

    init(title: String, description: String, date: Date?) {
        self.title = title
        self.description = description
        self.date = date
    }

    init?(dictToDo: [String: Any]) {
        guard
            let title = dictToDo["title"] as? String,
            let description = dictToDo["description"] as? String,
            let date = dictToDo["date"] as? Date
        else {
            return nil
        }
        self.title = title
        self.description = description
        self.date = date
    }
}
