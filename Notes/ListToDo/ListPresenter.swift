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
    func didPresentModelsFromDataBase(models: [DetailToDoModel])
}

class ListPresenter {
    weak var viewController: ListDisplayLogic?
}

extension ListPresenter: ListPresentationLogic {
    func didPresentModelsFromDataBase(models: [DetailToDoModel]) {
        let viewModels = models.map {
            ListCellViewModel(
                title: $0.title,
                description: $0.description,
                date: $0.date,
                iconUrl: $0.iconUrl
            )
        }
            viewController?.dispalyDataFromDataBase(viewModels: viewModels)
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
        viewController?.displayDataFromNetWork(viewModels: viewModels)
    }

    func didRaiseError(error: Error) {
        viewController?.dispalayErrorFromNetwork(error: error.localizedDescription)
    }
}
