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
    let userShareIcon: String?

    var isEmpty: Bool {
        if title.isEmpty && description.isEmpty {
            return true
        }
            return false
        }

    enum CodingKeys: String, CodingKey {
        case title = "header"
        case description = "text"
        case date = "date"
        case userShareIcon = "userShareIcon"
    }

    var dictionaryOfToDo: [String: Any] {
        var dictToDo: [String: Any] = [:]
        dictToDo["title"] = title
        dictToDo["description"] = description
        dictToDo["date"] = date
        return dictToDo
    }

    init(title: String, description: String, date: Date?, userShareIcon: String?) {
        self.title = title
        self.description = description
        self.date = date
        self.userShareIcon = userShareIcon
    }

    init?(dictToDo: [String: Any]) {
        guard
            let title = dictToDo["title"] as? String,
            let description = dictToDo["description"] as? String,
            let date = dictToDo["date"] as? Date
        else {
            return nil
        }

        let userShareIcon = (dictToDo["userShareIcon"] as? String) ?? nil

        self.title = title
        self.description = description
        self.date = date
        self.userShareIcon = userShareIcon
    }
}
