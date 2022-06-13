//
//  DetailToDoModel.swift
//  Notes
//
//  Created by Антон Макаров on 12.06.2022.
//

import Foundation

struct DetailToDoModel {
    var title: String
    var description: String
    var date: Date?
    var iconUrl: String?

    var isEmpty: Bool {
        if title.isEmpty && description.isEmpty {
            return true
        }
            return false
        }

    private enum DefaultsKeys: String {
        case title = "title"
        case description = "description"
        case date = "date"
        case iconUrl = "iconUrl"
    }

    var dictionaryOfModel: [String: Any] {
        var dictToDo: [String: Any] = [:]
        dictToDo[DefaultsKeys.title.rawValue] = title
        dictToDo[DefaultsKeys.description.rawValue] = description
        dictToDo[DefaultsKeys.date.rawValue] = date
        dictToDo[DefaultsKeys.iconUrl.rawValue] = iconUrl
        return dictToDo
    }

    init(title: String, description: String, date: Date?, iconUrl: String?) {
        self.title = title
        self.description = description
        self.date = date
        self.iconUrl = iconUrl
    }

    init?(dictModel: [String: Any]) {
        guard
            let title = dictModel[DefaultsKeys.title.rawValue] as? String,
            let description = dictModel[DefaultsKeys.description.rawValue] as? String,
            let date = dictModel[DefaultsKeys.date.rawValue] as? Date
        else {
            return nil
        }

        let iconUrl = (dictModel[DefaultsKeys.iconUrl.rawValue] as? String) ?? nil

        self.title = title
        self.description = description
        self.date = date
        self.iconUrl = iconUrl
    }
}
