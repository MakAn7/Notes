//
//  Enum + Keys.swift
//  Notes
//
//  Created by Антон Макаров on 25.03.2022.
//

import UIKit

final class NoteSettings {
     enum DefaultsKeys: String {
        case title = "Title"
        case description = "Description"
        case date = "Date"
    }
    static var title: String! {
        get {
            return UserDefaults.standard.string(forKey: DefaultsKeys.title.rawValue)
        } set {
            let defualts = UserDefaults.standard
            if let titleText = newValue {
                defualts.setValue(titleText, forKey: DefaultsKeys.title.rawValue)
            }
        }
    }

    static var description: String! {
        get {
            return UserDefaults.standard.string(forKey: DefaultsKeys.description.rawValue)
        } set {
            let defaults = UserDefaults.standard
            if let descriptionText = newValue {
                defaults.setValue(descriptionText, forKey: DefaultsKeys.description.rawValue)
            }
        }
    }

    static var date: String! {
        get {
            if let date = UserDefaults.standard.object(forKey: DefaultsKeys.date.rawValue) as? String {
            return date
            }
            return  ""
        } set {
            let defaults = UserDefaults.standard
            if let date = newValue {
                defaults.setValue(date, forKey: DefaultsKeys.date.rawValue)
            }
        }
    }
}
