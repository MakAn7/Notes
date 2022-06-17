//
//  DetailsToDoPresenterTests.swift
//  NotesTests
//
//  Created by Антон Макаров on 16.06.2022.
//

import XCTest
@testable import Notes
class DetailsToDoPresenterTests: XCTestCase {
    // MARK: - Public Properties

    var sut: DetailsToDoPresentationLogic!
    var viewController: DetailsToDoViewControllerSpy!

    override func setUp() {
        super.setUp()
        let presenter = DetailsToDoPresenter()
        viewController = DetailsToDoViewControllerSpy()
        presenter.viewController = viewController

        sut = presenter
    }

    override func tearDown() {
        sut = nil
        viewController = nil
        super.tearDown()
    }

    // MARK: - Public Methods

    func testsDetailsToDoViewControllerCalledThenCalledDetailsPresenterFuncPresentModel() {
        let detailModel = DetailToDoModel(
            title: "Foo",
            description: "Bar",
            date: .now,
            iconUrl: "Baz"
        )
        sut.presentModel(model: DetailModel.InitForm.Response(model: detailModel))
        XCTAssertTrue(
            viewController.didDisplayDataCalled,
            "Презентер должен вызвать у DetailsToDoViewController метод displayData()"
        )
    }
}
