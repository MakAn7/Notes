//  ListModels.swift
//  Notes
//  Created by Антон Макаров on 03.06.2022.

import Foundation

enum ListModels {
    enum InitForm {
        struct Request {}
        struct Response {
            let todos: [ToDo]
        }
        struct ViewModel {
            let listCellModels: [ListCellViewModel]
        }
    }

    enum InitError {
        struct Request {}
        struct Response {
            let responseError: CurrentError
        }
        struct ViewModel {
            let networkError: CurrentError
        }
    }

    enum FetchDataFromDataBase {
        struct Request {}
        struct Response {
            let modelsFromDataBase: [DetailToDoModel]
        }
        struct ViewModel {
            let modelsToDisplayFromDataBase: [ListCellViewModel]
        }
    }

    enum RemoveModel {
        struct Request {
            let index: Int
        }
        struct Response {}
        struct ViewModel {}
    }
}

struct ListCellViewModel {
    var title: String
    var description: String
    var date: Date?
    var iconUrl: String?
}
