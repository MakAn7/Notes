//  DetailsToDoInteractorTests.swift
//  NotesTests
//  Created by Антон Макаров on 15.06.2022.

import XCTest
@testable import Notes

final class DetailsToDoInteractorTests: XCTestCase {
    // MARK: - Public Properties
    var sut: DetailsToDoBusinessLogic!
    var userDefaultsService: DetailsToDoUserDefaultsSpy!
    var presenter: DetailsToDoPresenterSpy!

    let detailModel = DetailToDoModel(
        title: "Foo",
        description: "Bar",
        date: .now,
        iconUrl: "Baz"
    )
    override func setUp() {
        super.setUp()
        let interactor = DetailsToDoInteractor(state: .edit(model: detailModel, indexRow: 0))
        userDefaultsService = DetailsToDoUserDefaultsSpy()
        presenter = DetailsToDoPresenterSpy()
        interactor.presenter = presenter
        interactor.userDefaultsService = userDefaultsService

        sut = interactor
    }

    override func tearDown() {
        sut = nil
        presenter = nil
        userDefaultsService = nil
        super.tearDown()
    }

    func testsDetailToDoPresenterWasCalled() {
        sut.initToDoFromCell(request: DetailModel.InitForm.Request())
        XCTAssertTrue(presenter.didPresentModelCalled, "Презентер должен вызвать метод presentModel()")
    }

    func testsUserDefaultsServiceWasCalledUpdateModel() {
        sut.updateModelAtArray(model: DetailModel.UpdateModelFromDataBase.Request(model: detailModel))

        XCTAssertFalse(
            userDefaultsService.didPushModelCalled,
            "UserDefaultsService не должен вызвать метод pushModel()"
        )
        XCTAssertTrue(
            userDefaultsService.didUpdateModelCalled,
            "UserDefaultsService должен вызвать метод updateModel()"
        )
    }
}
