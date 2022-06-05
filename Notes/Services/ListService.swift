//
//  ListService.swift
//  Notes
//
//  Created by Антон Макаров on 05.06.2022.
//

import Foundation

struct ListService {
    private let networkService = NetworkService()

    func fetchToDos(
        onSuccess: @escaping([ToDo]) -> Void,
        onError: @escaping(CurrentError) -> Void
    ) {
        networkService.fetchModels(dataType: ToDo.self, from: API.getURL(), onSuccess: onSuccess, onError: onError)
    }
}
