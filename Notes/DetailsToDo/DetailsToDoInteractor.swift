//
//  DetailsToDoInteractor.swift
//  CleanSwiftNotes
//
//  Created by Антон Макаров on 05.06.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailsToDoBusinessLogic {
    func didPushModelsArray(model: ListCellViewModel)
    func didUpdateModelsArray(model: ListCellViewModel, indexModel: Int)
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
}
