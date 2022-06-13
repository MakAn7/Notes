//
//  DetailsToDoInteractor.swift
//  Notes
//
//  Created by Антон Макаров on 05.06.2022.
//

protocol DetailsToDoBusinessLogic {
    func updateModelAtArray(model: DetailModel.UpdateModelFromDataBase.Request)
    func initToDoFromCell(request: DetailModel.InitForm.Request)
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
    func updateModelAtArray(model: DetailModel.UpdateModelFromDataBase.Request) {
        switch state {
        case .new:
            userDefaultsService.pushModel(dictModel: model.model.dictionaryOfModel)
        case .edit:
            userDefaultsService.updateModel(dictModel: model.model.dictionaryOfModel, indexModel: indexRow)
        case .none:
            print( #function + "case .none")
        }
    }

    func initToDoFromCell(request: DetailModel.InitForm.Request) {
        presenter?.presentModel(model: DetailModel.InitForm.Response(model: model))
    }
}
