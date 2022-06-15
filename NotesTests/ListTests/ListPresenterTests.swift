//
//  ListPresenterTests.swift
//  NotesTests
//
//  Created by Антон Макаров on 15.06.2022.
//

import XCTest
@testable import Notes

final class ListPresenterTests: XCTestCase {
    // MARK: - Public Properties

    var sut: ListPresentationLogic!
    var viewController: ListViewControllerSpy!

    override func setUp() {
        super.setUp()
        let presenter = ListPresenter()
        viewController = ListViewControllerSpy()
        presenter.viewController = viewController

        sut = presenter
    }

    override func tearDown() {
        sut = nil
        viewController = nil
        super.tearDown()
    }

    // MARK: - Public Methods

    func testsListViewControllerWasCalledThenPresenterCalledFetchData() {
        let todos = [
            ToDo(title: "Foo", description: "Bar", date: .now, userShareIcon: "Baz"),
            ToDo(title: "Foo", description: "Bar", date: .now, userShareIcon: "Baz"),
            ToDo(title: "Foo", description: "Bar", date: .now, userShareIcon: "Baz")
        ]
        sut.fetchData(response: ListModels.InitForm.Response(todos: todos))
        XCTAssertTrue(viewController.didDisplayDataFromNetWorkCalled)
    }

    func testsListViewControllerWasCalledThenPresenterCalledRaiseError() {
        sut.raiseError(error: ListModels.InitError.Response(responseError: CurrentError.decodingError))
        XCTAssertTrue(
            viewController.didDispalayErrorFromNetworkCalled,
            "ViewController должен вызвать метод dispalayErrorFromNetwork()"
        )
    }

    func testsLIstViewControllerWasCalledThenPresenterCalledPresentModelsFromDataBase() {
        let detailModels = [
            DetailToDoModel(title: "Foo", description: "Bar", date: .now, iconUrl: "Baz"),
            DetailToDoModel(title: "Foo", description: "Bar", date: .now, iconUrl: "Baz"),
            DetailToDoModel(title: "Foo", description: "Bar", date: .now, iconUrl: "Baz")
        ]
        sut.presentModelsFromDataBase(
            models: ListModels.FetchDataFromDataBase.Response(modelsFromDataBase: detailModels)
        )
        XCTAssertTrue(
            viewController.didDispalyDataFromDataBaseCalled,
            "ViewController должен вызвать метод dispalayErrorFromNetwork()"
        )
    }
}
