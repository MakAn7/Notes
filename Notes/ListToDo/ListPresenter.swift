//
//  ListPresenter.swift
//  Notes
//
//  Created by Антон Макаров on 03.06.2022.
//

import UIKit

protocol ListPresentationLogic {
    func didFetchData(response: ListModels.InitForm.Response)
    func didRaiseError(error: ListModels.InitError.Response)
    func didPresentModelsFromDataBase(models: ListModels.FetchDataFromDataBase.Response)
}

class ListPresenter {
    // слабая ссылка для VIP цикла
    weak var viewController: ListDisplayLogic?
}

extension ListPresenter: ListPresentationLogic {
    func didPresentModelsFromDataBase(models: ListModels.FetchDataFromDataBase.Response) {
        let viewModels = models.modelsFromDataBase.map {
            ListCellViewModel(
                title: $0.title,
                description: $0.description,
                date: $0.date,
                iconUrl: $0.iconUrl
            )
        }
        viewController?.dispalyDataFromDataBase(
            viewModels: ListModels.FetchDataFromDataBase.ViewModel(modelsToDisplayFromDataBase: viewModels)
        )
    }

    func didFetchData(response: ListModels.InitForm.Response) {
        let viewModels = response.todos.map {
            ListCellViewModel(
                title: $0.title,
                description: $0.description,
                date: $0.date,
                iconUrl: $0.userShareIcon
            )
        }
        viewController?.displayDataFromNetWork(viewModels: ListModels.InitForm.ViewModel(listCellModels: viewModels))
    }

    func didRaiseError(error: ListModels.InitError.Response) {
        viewController?.dispalayErrorFromNetwork(
            error: ListModels.InitError.ViewModel(networkError: error.responseError)
        )
    }
}
