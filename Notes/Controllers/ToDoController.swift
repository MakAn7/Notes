//
//  ViewController.swift
//  Notes
//
//  Created by Антон Макаров on 25.03.2022.
//

import UIKit

class ToDoController: UIViewController {
    var todo: ToDo!
    lazy var indexToDo: Int = 0
    lazy var isNew = true
    weak var delegate: UpdateListDelegate?
    let toDoView = ToDoView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = toDoView
        toDoView.toDoTextView.becomeFirstResponder()
        registerKeybordNotification()
        setViews()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
        pushToDo()
    }

    private func setViews() {
        if let todo = todo {
            toDoView.titleTextField.text = todo.title
            toDoView.toDoTextView.text = todo.description
            toDoView.dateTextField.text = todo.date
        } else {
            toDoView.titleTextField.text = ""
            toDoView.toDoTextView.text = ""
            toDoView.dateTextField.text = ""
        }
    }

    private func setNavigationRightItem(isOn: Bool) {
        if isOn {
            let readyButton = createRightBarButton(image: "readyButton", selector: #selector(updateToDo))
            navigationItem.rightBarButtonItem = readyButton
        } else {
            navigationItem.rightBarButtonItems?.removeAll()
        }
    }

    private func pushToDo() {
        if let toDo = createToDo() {
            if isNew {
                ToDoSettings.shared.setArray(dictToDo: toDo.dictionaryOfToDo)
            } else {
                ToDoSettings.shared.updateToDo(dictToDo: toDo.dictionaryOfToDo, indexToDo: indexToDo)
            }
        }
        toDoView.endEditing(true)
        delegate?.updateViews()
    }

    private func createToDo() -> ToDo? {
        let titleText = toDoView.titleTextField.text ?? ""
        let descriptionText = toDoView.toDoTextView.text ?? ""
        let dateString = toDoView.dateTextField.text ?? ""

        let toDo = ToDo(
            title: titleText,
            description: descriptionText,
            date: dateString
        )

        if toDo.isEmpty {
            self.isMovingFromParent ? nil :
            alertShowError(message: "Заполните заголовок и поле заметки .", title: "Внимание !")
            return nil
        } else {
            let toDo = ToDo(
                title: titleText,
                description: descriptionText,
                date: setShortCurrentDate()
            )
            return toDo
        }
    }

    @objc
    private func updateToDo() {
        self.todo = createToDo()
        toDoView.endEditing(true)
    }
}

// MARK: - Setup current date
extension ToDoController {
    private func setLongCurrentDate() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy EEEE H:mm"
        let day = dateFormatter.string(from: date)
        toDoView.dateTextField.text = day
    }

    private func setShortCurrentDate() -> String? {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let day = dateFormatter.string(from: date)
        return day
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
        guard
            let userInfo = notification.userInfo,
            let keyboardFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        toDoView.toDoTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrameSize.height, right: 0)
        toDoView.toDoTextView.scrollIndicatorInsets = toDoView.toDoTextView.contentInset
        toDoView.toDoTextView.scrollRangeToVisible(toDoView.toDoTextView.selectedRange)
        toDoView.toDoTextView.autocorrectionType = .no
        toDoView.titleTextField.autocorrectionType = .no
        toDoView.titleTextField.spellCheckingType = .no
        setNavigationRightItem(isOn: true)
        setLongCurrentDate()
    }

    @objc
    private func keyboardDidHide() {
        toDoView.toDoTextView.contentInset = .zero
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
