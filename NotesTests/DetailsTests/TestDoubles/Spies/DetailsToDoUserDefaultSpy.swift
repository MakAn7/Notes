//  DetailsToDoUserDefaultsSpy.swift
//  NotesTests
//  Created by Антон Макаров on 15.06.2022.

import Foundation
@testable import Notes

final class DetailsToDoUserDefaultsSpy: DataStoreLogic {
    // MARK: - Private Properties
    private (set) var didPushModelCalled = false
    private (set) var didUpdateModelCalled = false
    private (set) var didFetchModelsCalled = false
    private (set) var didRemoveModelCalled = false

    var models = [
        DetailToDoModel(
            title: "Foo",
            description: "Bar",
            date: .now,
            iconUrl: "Baz"
        )
    ]

    // MARK: - Public Methods
    func pushModel(dictModel: [String: Any]) {
        didPushModelCalled = true
    }

    func updateModel(dictModel: [String: Any], indexModel: Int) {
        didUpdateModelCalled = true
    }

    func fetchModels() -> [DetailToDoModel] {
        didFetchModelsCalled = true
        return models
    }

    func removeModel(indexModel: Int) {
        didRemoveModelCalled = true
    }
}
