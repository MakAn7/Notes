//
//  UpdateListDelegate.swift
//  Notes
//
//  Created by Антон Макаров on 12.04.2022.
//

protocol UpdateListDelegate: AnyObject {
    func updateViews()
    func updateConstraints()
}

protocol UpdateActivityIndicatorDelegate: AnyObject {
    func stopActivityIndicator()
}
