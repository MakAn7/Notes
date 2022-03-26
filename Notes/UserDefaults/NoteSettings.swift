//
//  Enum + Keys.swift
//  Notes
//
//  Created by Антон Макаров on 25.03.2022.
//

import UIKit

final class NoteSettings {
    
    private enum DefaultsKeys: String {
        
        case title = "Title"
        case description = "Description"
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
}
