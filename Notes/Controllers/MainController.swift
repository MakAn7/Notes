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
        setCurrentDate()
        setNavigationBar()
        mainView.noteTextView.becomeFirstResponder()
        getDateFromPicker()
    }

    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Готово",
            style: .plain,
            target: self,
            action: #selector(pushNote)
        )
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(
            [.font: UIFont(name: "Helvetica-bold", size: 20) ?? ""], for: .normal
        )
    }

    func setCurrentDate() {
        if defaults.value(forKey: NoteSettings.DefaultsKeys.date.rawValue) == nil {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        let day = dateFormatter.string(from: date)
        mainView.dateTextField.text = day
        } else {
            getNote()
        }
    }

    @objc
    private func pushNote() {
        checkNote()
        mainView.endEditing(true)
    }

    private func getDateFromPicker() {
        mainView.datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
    }

    @objc
    private func dateChange() {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        mainView.dateTextField.text = formatter.string(from: mainView.datePicker.date)
    }

    private func getNote() {
        mainView.titleTextField.text = NoteSettings.title
        mainView.noteTextView.text = NoteSettings.description

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        let stringDate = dateFormatter.string(from: NoteSettings.date )
        mainView.dateTextField.text = stringDate
    }
}
