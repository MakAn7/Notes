//  ListServiceTests.swift
//  NotesTests
//  Created by Антон Макаров on 16.06.2022.

 import XCTest
 @testable import Notes

 class ListServiceTests: XCTestCase {
    // MARK: - Public Properties

     var sut: ListFetchDataLogic!
     var networkService: NetworkServiceSpy!
     var todosArray = [ToDo]()
     var error: Error!

    override func setUp() {
        super.setUp()
        let listService = ListService()
        networkService = NetworkServiceSpy()
        listService.networkService = networkService

        sut = listService
    }

    override func tearDown() {
        sut = nil
        networkService = nil
        super.tearDown()
    }

    // MARK: - Public Methods

    func testsNetworkServiceWasCalled() {
        let expectation = expectation(description: "async test fetch models")

        networkService.fetchResponse = {
            XCTAssertTrue(
                self.networkService.didFetchModelsWasCalled,
                "Интерактор должен вызвать через ListService метод NetworkService fetchModels()"
            )
            expectation.fulfill()
        }

        sut.fetchToDos { todos in
            self.todosArray = todos
        } onError: { error in
            self.error = error
        }

        wait(for: [expectation], timeout: 1)
    }
 }
