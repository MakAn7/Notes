//
//  ListInteractorMock.swift
//  NotesTests
//
//  Created by Антон Макаров on 14.06.2022.
//

import Foundation
@testable import Notes

final class ListInteractorMock: ListBusinessLogic {
    private (set) var didFetchModelsFromNetworcCalled = false
    private (set) var didFetchModelsFromDataBaseCalled = false
    private (set) var didRemoveModelFromDataBaseCalled = false

    func fetchModelsFromNetwork(request: ListModels.InitForm.Request) {
        didFetchModelsFromNetworcCalled = true
    }

    func fetchModelsFromDataBase(request: ListModels.FetchDataFromDataBase.Request) {
        didFetchModelsFromDataBaseCalled = true
    }

    func removeModelFromDataBase(indexModel: ListModels.RemoveModel.Request) {
        didRemoveModelFromDataBaseCalled = true
    }
}
