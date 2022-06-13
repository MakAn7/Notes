//
//  DetailsToDoInteractor.swift
//  Notes
//
//  Created by Антон Макаров on 05.06.2022.
//

protocol DetailsToDoBusinessLogic {
    func pushModelAtArray(model: DetailToDoModel)
    func updateModelAtArray(model: DetailToDoModel)
    func initToDoFromCell()
}

class DetailsToDoInteractor {
    var presenter: DetailsToDoPresentationLogic?
    private var userDefaultsService = UserDefaultsService()

    enum State {
        case new
        case edit(model: DetailToDoModel, indexRow: Int)
    }

    var state: State!
    var model: DetailToDoModel!
    var indexRow: Int = 0

    init(state: State) {
        self.state = state

        switch state {
        case .new:
            model = DetailToDoModel(
                title: "",
                description: "",
                date: .now,
                iconUrl: nil
            )
        case .edit(model: let model, indexRow: let indexRow):
            self.model = model
            self.indexRow = indexRow
        }
    }
}

extension DetailsToDoInteractor: DetailsToDoBusinessLogic {
    func pushModelAtArray(model: DetailToDoModel) {
        userDefaultsService.pushModel(dictModel: model.dictionaryOfModel)
    }

    func updateModelAtArray(model: DetailToDoModel) {
        switch state {
        case .new:
            userDefaultsService.pushModel(dictModel: model.dictionaryOfModel)
        case .edit:
            userDefaultsService.updateModel(dictModel: model.dictionaryOfModel, indexModel: indexRow)
        case .none:
            print( #function + "case .none")
        }
    }

    func initToDoFromCell() {
        presenter?.presentModel(model: model)
    }
}
