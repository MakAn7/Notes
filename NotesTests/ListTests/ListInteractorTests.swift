//  ListInteractorTest.swift
//  NotesTests
//  Created by Антон Макаров on 14.06.2022.

import XCTest
@testable import Notes
final class ListInteractorTest: XCTestCase {
    // MARK: - Public Properties

    var sut: ListBusinessLogic!
    var presenter: ListPresenterSpy!
    var listService: ListServiceSpy!
    var userDefaultsService: ListUserDefaultsSpy!

    override func setUp() {
        super.setUp()

        let interactor = ListInteractor()
        presenter = ListPresenterSpy()
        listService = ListServiceSpy()
        userDefaultsService = ListUserDefaultsSpy()
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

        XCTAssertTrue(
            presenter.didPresentModelsFromDataBaseCalled,
            "Интерактор должен вызвать метод ListPresenter presentModelsFromDataBase()"
        )
    }

    func testsListServiceWasCalled() {
        sut.fetchModelsFromNetwork(request: ListModels.InitForm.Request())

        XCTAssertTrue(listService.didFetchTodosCalled, "Интерактор должен вызвать метод ListService fetchToDos()")
        XCTAssertTrue(presenter.didFetchDataCalled, "Интерактор должен вызвать метод ListPresenter fetchData()")
        XCTAssertFalse(presenter.didRaiseErrorCalled, "Интерактор не должен вызвать метод ListPresenter raiseError()" )
    }

    func testsUserDefaultsServiceAndListPresenterWasCalled() {
        sut.fetchModelsFromDataBase(request: ListModels.FetchDataFromDataBase.Request())

        XCTAssertTrue(
            userDefaultsService.didFetchModels,
            "Интерактор должен вызвать метод UserDefaultsService fetchModels()"
        )
        XCTAssertTrue(
            presenter.didPresentModelsFromDataBaseCalled,
            "Интерактор должен вызвать метод ListPresenter didPresentModelsFromDataBase()"
        )
    }
    func testsUserDefaultsServiceWasCalled() {
        sut.removeModelFromDataBase(indexModel: ListModels.RemoveModel.Request(index: 0))

        XCTAssertTrue(
            userDefaultsService.didRemoveModel,
            "Интерактор должен вызвать метод UserDefaultsService removeModel()"
        )
    }
}
