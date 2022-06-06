//
//  DidUpdateViewAndConstaraints.swift
//  Notes
//
//  Created by Антон Макаров on 06.06.2022.
//

import Foundation

protocol DidUpdateViewAndConstaraintsDelegate: AnyObject {
    func didSetConstraintsToAddButton()
    func reloadData()
}
