//
//  ListInteractorTest.swift
//  NotesTests
//
//  Created by Антон Макаров on 14.06.2022.
//

import XCTest
@testable import Notes
final class NotesTests: XCTestCase {
    // MARK: - Private Properties

    var sut: ListBusinessLogic!
    var presenter: ListPresenterSpy!
    var listService: ListServiceSpy!

    override func setUp() {
        super.setUp()

        let interactor = ListInteractor()
        presenter = ListPresenterSpy()
        listService = ListServiceSpy()
        interactor.presenter = presenter
        interactor.listService = listService

        sut = interactor
    }

    override func tearDown() {
        sut = nil
        presenter = nil
        super.tearDown()
    }

    // MARK: - Public Methods
    func testsPresenterWasCalled() {
        sut.fetchModelsFromDataBase(request: ListModels.FetchDataFromDataBase.Request())

        XCTAssertTrue(presenter.didPresentModelsFromDataBaseCalled, "Интерактор должен вызвать метод Презентера")
    }

        func testsListServiceWasCalled() {
            sut.fetchModelsFromNetwork(request: ListModels.InitForm.Request())

            XCTAssertTrue(listService.didFetchTodosCalled, "Интерактор должен вызвать метод listService?.fetchToDos")
            XCTAssertTrue(presenter.didFetchDataCalled, "Презентер должен вызвать метод presenter?.didFetchData")
            XCTAssertFalse(presenter.didRaiseErrorCalled, "Презентер не должен вызвать метод presenter?.didRaiseError" )
        }
}
