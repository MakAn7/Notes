//
//  ListControllerTests.swift
//  NotesTests
//
//  Created by Антон Макаров on 14.06.2022.
//

import XCTest
@testable import Notes

class ListControllerTests: XCTestCase {
    var sut: ListViewController!
    var interactor: ListInteractorMock!

    override func setUp() {
        let viewController = ListViewController()
        let interactor = ListInteractorMock()
        viewController.interactor = interactor
        sut = viewController
    }

    override func tearDown() {
        sut = nil
        interactor = nil
        super.tearDown()
    }

    func testsTableView() {
        let tableViewMock = TableViewMock()
        let listCellModels = [
            ListCellViewModel(title: "Foo", description: "Bar", date: .now, iconUrl: "Baz"),
            ListCellViewModel(title: "Foo", description: "Bar", date: .now, iconUrl: "Baz"),
            ListCellViewModel(title: "Foo", description: "Bar", date: .now, iconUrl: "Baz")]

          sut.toDoTableView = tableViewMock
          sut.toDoTableView.dataSource = sut
          sut.displayDataFromNetWork(viewModels: ListModels.InitForm.ViewModel(listCellModels: listCellModels))
        XCTAssertTrue(tableViewMock.isCalledReloadData, "Обновление таблицы не началось")
        XCTAssertEqual(tableViewMock.numberOfRows(inSection: 0), listCellModels.count)
    }
}
