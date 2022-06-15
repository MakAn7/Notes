//
//  ListInteractorTest.swift
//  NotesTests
//
//  Created by Антон Макаров on 14.06.2022.
//

import XCTest
@testable import Notes
final class NotesTests: XCTestCase {
    // MARK: - Public Properties

    var sut: ListBusinessLogic!
    var presenter: ListPresenterSpy!
    var listService: ListServiceSpy!
    var userDefaultsService: UserDefaultsSpy!

    override func setUp() {
        super.setUp()

        let interactor = ListInteractor()
        presenter = ListPresenterSpy()
        listService = ListServiceSpy()
        userDefaultsService = UserDefaultsSpy()
        interactor.presenter = presenter
        interactor.listService = listService
        interactor.userDefaultsService = userDefaultsService

        sut = interactor
    }

    override func tearDown() {
        sut = nil
        presenter = nil
        listService = nil
        userDefaultsService = nil
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

    func testsUserDefaultsServiceAndListPresenterWasCalled() {
        sut.fetchModelsFromDataBase(request: ListModels.FetchDataFromDataBase.Request())

        XCTAssertTrue(userDefaultsService.didFetchModels, "userDefaultsService должен вызвать метод fetchModels()")
        XCTAssertTrue(
            presenter.didPresentModelsFromDataBaseCalled,
            "Презентер должен вызвать метод didPresentModelsFromDataBase()"
        )
    }
    func testsUserDefaultsServiceWasCalled() {
        sut.removeModelFromDataBase(indexModel: ListModels.RemoveModel.Request(index: 0))

        XCTAssertTrue(userDefaultsService.didRemoveModel, "userDefaultsService должен вызвать метод removeModel()")
    }
}
