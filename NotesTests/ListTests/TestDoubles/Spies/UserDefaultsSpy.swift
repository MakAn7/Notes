//
//  UserDefaultsSpy.swift
//  NotesTests
//
//  Created by Антон Макаров on 15.06.2022.
//

import Foundation
@testable import Notes

final class UserDefaultsSpy: ListDataStoreLogic {
    private (set) var didPushModel = false
    private (set) var didUpdateModel = false
    private (set) var didFetchModels = false
    private (set) var didRemoveModel = false

    var models = [
        DetailToDoModel(
            title: "Foo",
            description: "Bar",
            date: .now,
            iconUrl: "Baz"
        )
    ]

    func pushModel(dictModel: [String: Any]) {
        didPushModel = true
    }

    func updateModel(dictModel: [String: Any], indexModel: Int) {
        didUpdateModel = true
    }

    func fetchModels() -> [DetailToDoModel] {
        didFetchModels = true
        return models
    }

    func removeModel(indexModel: Int) {
        didRemoveModel = true
    }
}
