//
//  ExtensionsMainController.swift
//  Notes
//
//  Created by Антон Макаров on 01.04.2022.
//

import UIKit

extension MainController {
    func checkNote() {
        let titleText = mainView.titleTextField.text ?? ""
        let descriptionText = mainView.noteTextView.text ?? ""
        let dateString = mainView.dateTextField.text ?? ""

        let note = Note(
            title: titleText,
            description: descriptionText,
            date: dateString
        )

        if note.isEmpty {
            alertShowError(message: "Заполните заголовок и поле заметки .", title: "Внимание !")
        } else {
            NoteSettings.title = titleText
            NoteSettings.description = descriptionText
            NoteSettings.date = dateString
        }
    }

    func alertShowError(message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
