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

   private enum CodingKeys: String, CodingKey {
        case title = "header"
        case description = "text"
        case date = "date"
        case userShareIcon = "userShareIcon"
    }

    private enum DefaultsKeys: String {
        case title = "title"
        case description = "description"
        case date = "date"
        case userShareIcon = "userShareIcon"
    }

    var dictionaryOfToDo: [String: Any] {
        var dictToDo: [String: Any] = [:]
        dictToDo[DefaultsKeys.title.rawValue] = title
        dictToDo[DefaultsKeys.description.rawValue] = description
        dictToDo[DefaultsKeys.date.rawValue] = date
        dictToDo[DefaultsKeys.userShareIcon.rawValue] = userShareIcon
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
            let title = dictToDo[DefaultsKeys.title.rawValue] as? String,
            let description = dictToDo[DefaultsKeys.description.rawValue] as? String,
            let date = dictToDo[DefaultsKeys.date.rawValue] as? Date
        else {
            return nil
        }

        let userShareIcon = (dictToDo[DefaultsKeys.userShareIcon.rawValue] as? String) ?? nil

        self.title = title
        self.description = description
        self.date = date
        self.userShareIcon = userShareIcon
    }
}
