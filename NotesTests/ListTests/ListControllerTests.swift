//
//  ListControllerTests.swift
//  NotesTests
//
//  Created by Антон Макаров on 14.06.2022.
//

import XCTest
@testable import Notes

final class ListControllerTests: XCTestCase {
    // MARK: - Public Properties

    var sut: ListViewController!
    var interactor: ListInteractorSpy!

    override func setUp() {
        let viewController = ListViewController()
        let interactor = ListInteractorSpy()
        viewController.interactor = interactor
        sut = viewController
    }

    override func tearDown() {
        sut = nil
        interactor = nil
        super.tearDown()
    }

    // MARK: - Public Methods
    func testsReloadTableViewThenDidSetDataFromNetWork() {
        let tableViewSpy = TableViewSpy()
        let listCellModels = [
            ListCellViewModel(title: "Foo", description: "Bar", date: .now, iconUrl: "Baz"),
            ListCellViewModel(title: "Foo", description: "Bar", date: .now, iconUrl: "Baz"),
            ListCellViewModel(title: "Foo", description: "Bar", date: .now, iconUrl: "Baz")]

        sut.toDoTableView = tableViewSpy
        sut.toDoTableView.dataSource = sut
        sut.displayDataFromNetwork(viewModels: ListModels.InitForm.ViewModel(listCellModels: listCellModels))

        XCTAssertTrue(tableViewSpy.isCalledReloadData, "Обновление таблицы не началось")
        XCTAssertEqual(tableViewSpy.numberOfRows(inSection: 0), listCellModels.count)
    }

    func testsReloadTableViewThenDidSetDataFromDataBase() {
        let tableViewSpy = TableViewSpy()
        let listCellModels = [
            ListCellViewModel(title: "Foo", description: "Bar", date: .now, iconUrl: "Baz"),
            ListCellViewModel(title: "Foo", description: "Bar", date: .now, iconUrl: "Baz"),
            ListCellViewModel(title: "Foo", description: "Bar", date: .now, iconUrl: "Baz")]

        sut.toDoTableView = tableViewSpy
        sut.toDoTableView.dataSource = sut
        sut.dispalyDataFromDataBase(
            viewModels: ListModels.FetchDataFromDataBase.ViewModel(
            modelsToDisplayFromDataBase: listCellModels
            )
        )

        XCTAssertTrue(tableViewSpy.isCalledReloadData, "Обновление таблицы не началось")
        XCTAssertEqual(tableViewSpy.numberOfRows(inSection: 0), listCellModels.count)
    }
}
