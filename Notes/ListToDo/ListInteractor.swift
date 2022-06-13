//
//  ListInteractor.swift
//  Notes
//
//  Created by Антон Макаров on 03.06.2022.
//

import UIKit

protocol ListBusinessLogic {
    func fetchModelsFromNetwork(request: ListModels.InitForm.Request)
    func fetchModelsFromDataBase(request: ListModels.FetchDataFromDataBase.Request)
    func removeModelFromDataBase(indexModel: ListModels.RemoveModel.Request)
}

class ListInteractor {
  var presenter: ListPresentationLogic?
  private var listService = ListService()
  private var userDefaultsService = UserDefaultsService()
}

// MARK: - Protocols
extension ListInteractor: ListBusinessLogic {
    func removeModelFromDataBase(indexModel: ListModels.RemoveModel.Request) {
        userDefaultsService.didRemoveModel(indexModel: indexModel.index)
    }

    func fetchModelsFromNetwork(request: ListModels.InitForm.Request) {
        listService.fetchToDos(onSuccess: { [weak self] todos in
            self?.presenter?.didFetchData(response: ListModels.InitForm.Response(todos: todos))
        }, onError: { [weak self] error in
            self?.presenter?.didRaiseError(error: ListModels.InitError.Response(responseError: error))
        })
    }

    func fetchModelsFromDataBase(request: ListModels.FetchDataFromDataBase.Request) {
        let models = userDefaultsService.fetchModels()
        presenter?.didPresentModelsFromDataBase(
            models: ListModels.FetchDataFromDataBase.Response(modelsFromDataBase: models)
        )
    }
}
