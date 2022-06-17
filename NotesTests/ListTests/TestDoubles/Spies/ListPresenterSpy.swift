//  ListPresenterSpy.swift
//  NotesTests
//  Created by Антон Макаров on 14.06.2022.

import UIKit
@testable import Notes

final class ListPresenterSpy: ListPresentationLogic {
    // MARK: - Private Properties
    private (set) var didFetchDataCalled = false
    private (set) var didRaiseErrorCalled = false
    private (set) var didPresentModelsFromDataBaseCalled = false

    // MARK: - Public Methods
    func fetchData(response: ListModels.InitForm.Response) {
        didFetchDataCalled = true
    }

    func raiseError(error: ListModels.InitError.Response) {
        didRaiseErrorCalled = true
    }

    func presentModelsFromDataBase(models: ListModels.FetchDataFromDataBase.Response) {
        didPresentModelsFromDataBaseCalled = true
    }
}
