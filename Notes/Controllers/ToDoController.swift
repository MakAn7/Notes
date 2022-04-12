//
//  ViewController.swift
//  Notes
//
//  Created by Антон Макаров on 25.03.2022.
//

import UIKit

class ToDoController: UIViewController {
    lazy var isNew = true
    var todo: ToDo?
    var index: Int = 0
    weak var delegate: UpdateListDelegate?
    let mainView = ToDoView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        mainView.noteTextView.becomeFirstResponder()
        registerKeybordNotification()
        setViews()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }

    private func setViews() {
        if let todo = todo {
            mainView.titleTextField.text = todo.title
            mainView.noteTextView.text = todo.description
        } else {
            mainView.titleTextField.text = ""
            mainView.noteTextView.text = ""
        }
        setCurrentDate()
    }

    private func setNavigationRightItem(isOn: Bool) {
        if isOn {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Готово",
                style: .plain,
                target: self,
                action: #selector(pushNote)
            )
            navigationItem.rightBarButtonItem?.setTitleTextAttributes(
                [.font: UIFont(name: "Helvetica", size: 16) ?? ""], for: .normal
            )
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }

    @objc
    private func pushNote() {
        if let toDo = createNote() {
            if isNew {
                NoteSettings.shared.setArray(dictToDo: toDo.dictionaryOfToDo)
            } else {
                NoteSettings.shared.updateToDo(dictToDo: toDo.dictionaryOfToDo, index: index)
            }
        }
        mainView.endEditing(true)
        delegate?.updateViews()
    }

   private func createNote() -> ToDo? {
        let titleText = mainView.titleTextField.text ?? ""
        let descriptionText = mainView.noteTextView.text ?? ""
        let dateString = mainView.dateTextField.text ?? ""

        let toDo = ToDo(
            title: titleText,
            description: descriptionText,
            date: dateString
        )

        if toDo.isEmpty {
            alertShowError(message: "Заполните заголовок и поле заметки .", title: "Внимание !")
            return nil
        } else {
            let toDo = ToDo(title: titleText, description: descriptionText, date: dateString)
            return toDo
        }
    }
}

// MARK: - Setup current date
extension ToDoController {
    private func setCurrentDate() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy EEEE H:mm"
        let day = dateFormatter.string(from: date)
        mainView.dateTextField.text = day
    }
}
// MARK: - Setup settings with keyboard
extension ToDoController {
    func registerKeybordNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidHide),
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
    }
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
    }
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo
        let keyboardFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue ??
                                 NSValue(nonretainedObject: 0)).cgRectValue
        mainView.noteTextView.contentSize = CGSize(
            width: view.frame.width,
            height: mainView.noteTextView.frame.height + keyboardFrameSize.height
        )
        setNavigationRightItem(isOn: true)
    }
    @objc
    private func keyboardDidHide() {
        mainView.noteTextView.contentOffset = .zero
        setNavigationRightItem(isOn: false)
    }
}
// MARK: - Error alert
extension ToDoController {
    func alertShowError(message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
