//
//  CheckNote.swift
//  Notes
//
//  Created by Антон Макаров on 01.04.2022.
//

import UIKit

extension MainController {
    func checkNote() {
        let titleText = mainView.titleTextField.text ?? ""
        let descriptionText = mainView.noteTextView.text ?? ""
        let date = mainView.datePicker.date

        let note = Note(
            title: titleText,
            description: descriptionText,
            date: date
        )

        if note.isEmpty {
            alertShowError(message: "Заполните заголовок и поле заметки .", title: "Внимание !")
        } else {
            NoteSettings.title = titleText
            NoteSettings.description = descriptionText
            NoteSettings.date = date
        }
    }
}
