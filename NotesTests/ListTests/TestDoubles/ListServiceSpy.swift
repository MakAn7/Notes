//
//  ListServiceSpy.swift
//  NotesTests
//
//  Created by Антон Макаров on 14.06.2022.
//

import Foundation
@testable import Notes

final class ListServiceSpy: ListFetchDataLogic {
    private (set) var didFetchTodosCalled = false

    let todos = [
        ToDo(
            title: "Foo",
            description: "Bar",
            date: .now,
            userShareIcon: "Baz"
        ),
        ToDo(
            title: "Foo",
            description: "Bar",
            date: .now,
            userShareIcon: "Baz"
        )
    ]

    func fetchToDos(
        onSuccess: @escaping([ToDo]) -> Void,
        onError: @escaping(CurrentError) -> Void
    ) {
        didFetchTodosCalled = true
        onSuccess(todos)
    }
}
