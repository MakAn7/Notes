//  UserDefaultsService.swift
//  Notes
//  Created by Антон Макаров on 06.06.2022.

import UIKit

private enum DefaultsKeys: String {
    case array = "Array"
}

protocol DataStoreLogic {
    func pushModel(dictModel: [String: Any])
    func updateModel(dictModel: [String: Any], indexModel: Int)
    func fetchModels() -> [DetailToDoModel]
    func removeModel(indexModel: Int)
}

final class UserDefaultsService: DataStoreLogic {
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

    func fetchModels() -> [DetailToDoModel] {
        var models = [DetailToDoModel]()
        if let array = defaults.array(forKey: DefaultsKeys.array.rawValue) as? [[String: Any]] {
            for dictModel in array {
                guard let model = DetailToDoModel(dictModel: dictModel) else {
                    continue
                }
                models.append(model)
            }
            return models
        } else {
            return []
        }
    }

    func removeModel(indexModel: Int) {
        guard var array = defaults.array(forKey: DefaultsKeys.array.rawValue) as? [[String: Any]] else {
            fatalError("Don't fetch array of ToDo")
        }

        if array.indices.contains(indexModel) {
            array.remove(at: indexModel)
        }
        defaults.setValue(array, forKey: DefaultsKeys.array.rawValue)
    }
}
