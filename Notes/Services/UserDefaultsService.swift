//
//  UserDefaultsService.swift
//  Notes
//
//  Created by Антон Макаров on 06.06.2022.
//

import UIKit

private enum DefaultsKeys: String {
    case array = "Array"
}

final class UserDefaultsService {
    let defaults = UserDefaults.standard

    func pushModel(dictModel: [String: Any]) {
        if var array = defaults.array(forKey: DefaultsKeys.array.rawValue) as? [[String: Any]] {
            array.append(dictModel)
            defaults.setValue(array, forKey: DefaultsKeys.array.rawValue)
        } else {
            let array: [[String: Any]] = [dictModel]
            defaults.setValue(array, forKey: DefaultsKeys.array.rawValue)
        }
    }

    func updateModel(dictModel: [String: Any], indexModel: Int) {
        if var array = defaults.array(forKey: DefaultsKeys.array.rawValue) as? [[String: Any]] {
            indexModel < array.count ?
            array[indexModel] = dictModel :
            array.append(dictModel)
            defaults.setValue(array, forKey: DefaultsKeys.array.rawValue)
        } else {
            let array: [[String: Any]] = [dictModel]
            defaults.setValue(array, forKey: DefaultsKeys.array.rawValue)
        }
    }

    func didFetchModels() -> [ListCellViewModel] {
        var models = [ListCellViewModel]()
        if let array = defaults.array(forKey: DefaultsKeys.array.rawValue) as? [[String: Any]] {
            for dictModel in array {
                guard let model = ListCellViewModel(dictToDo: dictModel) else {
                    continue
                }
                models.append(model)
            }
            return models
        } else {
            return []
        }
    }

    func didRemoveModel (indexModel: Int) {
        guard var array = defaults.array(forKey: DefaultsKeys.array.rawValue) as? [[String: Any]] else {
            fatalError("Don't fetch array of ToDo")
        }
        if array.indices.contains(indexModel) {
            array.remove(at: indexModel)
        }
        defaults.setValue(array, forKey: DefaultsKeys.array.rawValue)
    }
}
