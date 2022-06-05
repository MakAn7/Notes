//
//  ConvertDateToString.swift
//  Notes
//
//  Created by Антон Макаров on 21.04.2022.
//

import UIKit

func convertDateToString(date: Date?, short format: Bool) -> String {
    let dateFormatter = DateFormatter()
    if format {
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let shortDate = dateFormatter.string(from: date ?? Date())
        return shortDate
    }
    dateFormatter.dateFormat = "dd.MM.yyyy EEEE H:mm"
    let longDate = dateFormatter.string(from: date ?? Date())
    return longDate
}
