//  Note.swift
//  Notes
//  Created by Антон Макаров on 01.04.2022.

import Foundation

struct ToDo: Decodable {
    let title: String
    let description: String
    let date: Date?
    let userShareIcon: String?

   private enum CodingKeys: String, CodingKey {
        case title = "header"
        case description = "text"
        case date = "date"
        case userShareIcon = "userShareIcon"
    }
}
