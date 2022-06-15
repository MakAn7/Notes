//
//  ListService.swift
//  Notes
//
//  Created by Антон Макаров on 05.06.2022.
//

import Foundation

protocol ListFetchDataLogic {
    func fetchToDos(
        onSuccess: @escaping([ToDo]) -> Void,
        onError: @escaping(CurrentError) -> Void
    )
}

class ListService {
    private let networkService = NetworkService()
}

extension ListService: ListFetchDataLogic {
    func fetchToDos(
        onSuccess: @escaping([ToDo]) -> Void,
        onError: @escaping(CurrentError) -> Void
    ) {
        networkService.fetchModels(dataType: ToDo.self, from: API.getURL(), onSuccess: onSuccess, onError: onError)
    }
}
