//  ListViewControllerSpy.swift
//  NotesTests
//  Created by Антон Макаров on 15.06.2022.

import Foundation
@testable import Notes

final class ListViewControllerSpy: ListDisplayLogic {
    // MARK: - Private Properties
    private (set) var didDisplayDataFromNetWorkCalled = false
    private (set) var didDispalyDataFromDataBaseCalled = false
    private (set) var didDispalayErrorFromNetworkCalled = false

    // MARK: - Public Methods
    func displayDataFromNetwork(viewModels: ListModels.InitForm.ViewModel) {
        didDisplayDataFromNetWorkCalled = true
    }

    func dispalyDataFromDataBase(viewModels: ListModels.FetchDataFromDataBase.ViewModel) {
        didDispalyDataFromDataBaseCalled = true
    }

    func dispalayErrorFromNetwork(error: ListModels.InitError.ViewModel) {
        didDispalayErrorFromNetworkCalled = true
    }
}
