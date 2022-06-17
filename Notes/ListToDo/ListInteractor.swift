//  ListInteractor.swift
//  Notes
//  Created by Антон Макаров on 03.06.2022.

import UIKit

protocol ListBusinessLogic {
    func fetchModelsFromNetwork(request: ListModels.InitForm.Request)
    func fetchModelsFromDataBase(request: ListModels.FetchDataFromDataBase.Request)
    func removeModelFromDataBase(indexModel: ListModels.RemoveModel.Request)
}

class ListInteractor {
    var presenter: ListPresentationLogic?
    var listService: ListFetchDataLogic?
    var userDefaultsService: DataStoreLogic?
}

// MARK: - Protocols
extension ListInteractor: ListBusinessLogic {
    func removeModelFromDataBase(indexModel: ListModels.RemoveModel.Request) {
        userDefaultsService?.removeModel(indexModel: indexModel.index)
    }

    func fetchModelsFromNetwork(request: ListModels.InitForm.Request) {
        // слабая или безхозная ссылка не нужна, цикла не образуется
        listService?.fetchToDos(onSuccess: { todos in
            self.presenter?.fetchData(response: ListModels.InitForm.Response(todos: todos))
        }, onError: { error in
            self.presenter?.raiseError(error: ListModels.InitError.Response(responseError: error))
        })
    }

    func fetchModelsFromDataBase(request: ListModels.FetchDataFromDataBase.Request) {
        let models = userDefaultsService?.fetchModels()
        presenter?.presentModelsFromDataBase(
            models: ListModels.FetchDataFromDataBase.Response(modelsFromDataBase: models ?? [])
        )
    }
}
