//
//  ViewController.swift
//  Notes
//
//  Created by Антон Макаров on 25.03.2022.
//

import UIKit

class MainController: UIViewController {
    private let defaults = UserDefaults.standard

    let mainView = MainView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        setNavigationBar()
        mainView.noteTextView.becomeFirstResponder()
        getNote()
    }

    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Готово",
            style: .plain,
            target: self,
            action: #selector(saveNote)
        )

        navigationItem.rightBarButtonItem?.setTitleTextAttributes(
            [.font: UIFont(name: "Helvetica-bold", size: 20) ?? ""], for: .normal
        )
    }
    private func getNote() {
        mainView.titleTextField.text = NoteSettings.title
        mainView.noteTextView.text = NoteSettings.description
    }

    @objc
    private func saveNote() {
        
        let titleText = mainView.titleTextField.text ?? ""
        NoteSettings.title = titleText
        
        let descriptionText = mainView.noteTextView.text ?? ""
        NoteSettings.description = descriptionText
        mainView.endEditing(true)
    }
}
