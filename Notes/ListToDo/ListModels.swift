//
//  ListModels.swift
//  Notes
//
//  Created by Антон Макаров on 03.06.2022.
//

import Foundation

struct ListCellViewModel {
    var title: String
    var description: String
    var date: String
    var iconUrl: URL?
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

    var dictionaryOfToDo: [String: Any] {
        var dictToDo: [String: Any] = [:]
        dictToDo[DefaultsKeys.title.rawValue] = title
        dictToDo[DefaultsKeys.description.rawValue] = description
        dictToDo[DefaultsKeys.date.rawValue] = date
        dictToDo[DefaultsKeys.iconUrl.rawValue] = iconUrl
        return dictToDo
    }

    init(title: String, description: String, date: String, iconUrl: URL?) {
        self.title = title
        self.description = description
        self.date = date
        self.iconUrl = iconUrl
    }

    init?(dictToDo: [String: Any]) {
        guard
            let title = dictToDo[DefaultsKeys.title.rawValue] as? String,
            let description = dictToDo[DefaultsKeys.description.rawValue] as? String,
            let date = dictToDo[DefaultsKeys.date.rawValue] as? String
        else {
            return nil
        }

        let iconUrl = (dictToDo[DefaultsKeys.iconUrl.rawValue] as? URL) ?? nil

        self.title = title
        self.description = description
        self.date = date
        self.iconUrl = iconUrl
    }
}
