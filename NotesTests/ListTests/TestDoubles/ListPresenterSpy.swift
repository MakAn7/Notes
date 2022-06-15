//
//  ListPresenterSpy.swift
//  NotesTests
//
//  Created by Антон Макаров on 14.06.2022.
//

import UIKit
@testable import Notes

final class ListPresenterSpy: ListPresentationLogic {
   private (set) var didFetchDataCalled = false
   private (set) var didRaiseErrorCalled = false
   private (set) var didPresentModelsFromDataBaseCalled = false

    func didFetchData(response: ListModels.InitForm.Response) {
        didFetchDataCalled = true
    }

    func didRaiseError(error: ListModels.InitError.Response) {
        didRaiseErrorCalled = true
    }

    func didPresentModelsFromDataBase(models: ListModels.FetchDataFromDataBase.Response) {
        didPresentModelsFromDataBaseCalled = true
    }
}
