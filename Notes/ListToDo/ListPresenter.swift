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
}

class ListPresenter {
  weak var viewController: ListDisplayLogic?
}

extension ListPresenter: ListPresentationLogic {
    func didFetchData(todos: [ToDo]) {
        let viewModels = todos.map {
            ListCellViewModel(
                title: $0.title,
                description: $0.description,
                date: convertDateToString(date: $0.date, short: true),
                iconUrl: $0.userShareIcon.flatMap { url in URL(string: url) }
            )
        }
        viewController?.displayData(viewModels: viewModels)
    }

    func didRaiseError(error: Error) {
        viewController?.dispalayError(error: error.localizedDescription)
    }
}
