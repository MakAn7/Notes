//
//  ListInteractor.swift
//  Notes
//
//  Created by Антон Макаров on 03.06.2022.
//

import UIKit

protocol ListBusinessLogic {
    func fetchToDo()
}

class ListInteractor {
  var presenter: ListPresentationLogic?
  private var listService = ListService()
}

// MARK: - Protocols
extension ListInteractor: ListBusinessLogic {
    func fetchToDo() {
        listService.fetchToDos(onSuccess: { [weak self] todos in
            self?.presenter?.didFetchData(todos: todos)
        }, onError: { [weak self] error in
            self?.presenter?.didRaiseError(error: error)
        })
    }
}
