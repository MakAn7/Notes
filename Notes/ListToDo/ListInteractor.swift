//
//  ListInteractor.swift
//  Notes
//
//  Created by Антон Макаров on 03.06.2022.
//

import UIKit

protocol ListBusinessLogic {
    func fetchModelsFromInet()
    func fetchModelsFromDataBase()
}

class ListInteractor {
  var presenter: ListPresentationLogic?
  private var listService = ListService()
  private var userDefaultsService = UserDefaultsService()
}

// MARK: - Protocols
extension ListInteractor: ListBusinessLogic {
    func fetchModelsFromInet() {
        listService.fetchToDos(onSuccess: { [weak self] todos in
            self?.presenter?.didFetchData(todos: todos)
        }, onError: { [weak self] error in
            self?.presenter?.didRaiseError(error: error)
        })
    }

    func fetchModelsFromDataBase() {
        let models = userDefaultsService.didFetchModels()
        presenter?.didPresentModelsFromDataBase(models: models)
    }
}
