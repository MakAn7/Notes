//
//  DetailsToDoInteractor.swift
//  Notes
//
//  Created by Антон Макаров on 05.06.2022.
//

import UIKit

protocol DetailsToDoBusinessLogic {
    func pushModelAtArray(model: ListCellViewModel)
    func updateModelAtArray(model: ListCellViewModel, indexModel: Int)
}

class DetailsToDoInteractor {
    var presenter: DetailsToDoPresentationLogic?
    private var userDefaultsService = UserDefaultsService()
}
extension DetailsToDoInteractor: DetailsToDoBusinessLogic {
    func pushModelAtArray(model: ListCellViewModel) {
        userDefaultsService.pushModel(dictModel: model.dictionaryOfModel)
    }

    func updateModelAtArray(model: ListCellViewModel, indexModel: Int) {
        userDefaultsService.updateModel(dictModel: model.dictionaryOfModel, indexModel: indexModel)
    }
}
