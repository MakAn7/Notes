//
//  ListPresenter.swift
//  Notes
//
//  Created by Антон Макаров on 03.06.2022.
//

import UIKit

protocol ListPresentationLogic {
    func didFetchData(todos: [ToDo])
    func didRaiseError(error: Error)
    func didpresentModelsFromDataBase(models: [ListCellViewModel])
}

class ListPresenter {
  weak var viewController: ListDisplayLogic?
}

extension ListPresenter: ListPresentationLogic {
    func didpresentModelsFromDataBase(models: [ListCellViewModel]) {
        viewController?.dispalyDataFromDataBase(viewModels: models)
    }

    func didFetchData(todos: [ToDo]) {
        let viewModels = todos.map {
            ListCellViewModel(
                title: $0.title,
                description: $0.description,
                date: $0.date,
                iconUrl: $0.userShareIcon
            )
        }
        viewController?.displayDataFromInet(viewModels: viewModels)
    }

    func didRaiseError(error: Error) {
        viewController?.dispalayErrorFromInet(error: error.localizedDescription)
    }
}
