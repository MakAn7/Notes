//
//  TableView.swift
//  NotesTests
//
//  Created by Антон Макаров on 14.06.2022.
//

import UIKit

final class TableViewSpy: UITableView {
  private(set) var isCalledReloadData = false

  override func reloadData() {
    super.reloadData()
    isCalledReloadData = true
  }
}
