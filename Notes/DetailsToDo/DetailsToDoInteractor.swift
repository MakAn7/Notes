//
//  DetailsToDoInteractor.swift
//  Notes
//
//  Created by Антон Макаров on 05.06.2022.
//

import UIKit

protocol DetailsToDoBusinessLogic {
    func didPushModelsArray(model: ListCellViewModel)
    func didUpdateModelsArray(model: ListCellViewModel, indexModel: Int)
//    func didFetchModelsArray()
}

class DetailsToDoInteractor {
  var presenter: DetailsToDoPresentationLogic?
    private var userDefaultsService = UserDefaultsService()
}
extension DetailsToDoInteractor: DetailsToDoBusinessLogic {
    func didPushModelsArray(model: ListCellViewModel) {
        userDefaultsService.didPushModel(dictModel: model.dictionaryOfToDo)
    }

    func didUpdateModelsArray(model: ListCellViewModel, indexModel: Int) {
        userDefaultsService.didUpdateModel(dictModel: model.dictionaryOfToDo, indexModel: indexModel)
    }

//    func didFetchModelsArray() {
//        let models = userDefaultsService.didFetchModels()
//        presenter?.didPresentModels(models: models)
//    }
}
