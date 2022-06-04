//
//  UpdateListDelegate.swift
//  Notes
//
//  Created by Антон Макаров on 12.04.2022.
//

protocol UpdateListDelegate: AnyObject {
    func fetchToDosFromUserDefault()
    func updateConstraints()
    func didRemoveAllTodosArray()
}
