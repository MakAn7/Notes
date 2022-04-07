//
//  Note.swift
//  Notes
//
//  Created by Антон Макаров on 01.04.2022.
//

import Foundation

struct Note {
    let title: String
    let description: String
    let date: String?

    var isEmpty: Bool {
        if title.isEmpty && description.isEmpty {
          return true
        } else {
            return false
        }
    }
}
