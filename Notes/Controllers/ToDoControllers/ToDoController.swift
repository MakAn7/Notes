//
//  ViewController.swift
//  Notes
//
//  Created by Антон Макаров on 25.03.2022.
//

import UIKit

class ToDoController: UIViewController {
    enum State {
        case new
        case edit(todo: ToDo, index: Int)
    }

    var todo: ToDo!
    let state: State
    lazy var indexToDo: Int = 0
    weak var delegate: UpdateListDelegate?
    let toDoView = ToDoView()

    init(state: State, delegate: UpdateListDelegate) {
        self.delegate = delegate
        self.state = state
        super.init(nibName: nil, bundle: nil)

        switch state {
        case .new:
            self.todo = ToDo(title: "", description: "", date: nil, userShareIcon: nil)
        case .edit(let todo, let index):
            self.todo = todo
            self.indexToDo = index
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        toDoView.titleTextField.text = todo.title
        toDoView.toDoTextView.text = todo.description
        if let date = todo.date {
            toDoView.dateTextField.text = convertDateToString(date: date, short: false)
        }
    }

    private func setNavigationRightItem(isOn: Bool) {
        if isOn {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Готово",
                style: .plain,
                target: self,
                action: #selector(updateToDo)
            )
            navigationItem.rightBarButtonItem?.setTitleTextAttributes(
                [.font: UIFont(name: FontsLibrary.SFProTextRegular.rawValue, size: 17) ?? ""], for: .normal
            )
        } else {
            navigationItem.rightBarButtonItems?.removeAll()
        }
    }

    private func pushToDo() {
        delegate?.updateConstraints()
        if let toDo = createToDo() {
            switch state {
            case .new:
                ToDoSettings.shared.pushArray(dictToDo: toDo.dictionaryOfToDo)
            case .edit:
                ToDoSettings.shared.updateToDo(dictToDo: toDo.dictionaryOfToDo, indexToDo: indexToDo)
            }
        }
        toDoView.endEditing(true)
        delegate?.updateViews()
    }

    private func createToDo() -> ToDo? {
        let titleText = toDoView.titleTextField.text ?? ""
        let descriptionText = toDoView.toDoTextView.text ?? ""

        let toDo = ToDo(
            title: titleText,
            description: descriptionText,
            date: nil,
            userShareIcon: nil
        )

        if toDo.isEmpty {
            self.isMovingFromParent ? nil :
            alertShowError(message: "Заполните заголовок и поле заметки .", title: nil)
            return nil
        }
            let currentToDo = ToDo(
                title: titleText,
                description: descriptionText,
                date: setLongCurrentDate(),
                userShareIcon: nil
            )
            return currentToDo
    }

    @objc
    private func updateToDo() {
        self.todo = createToDo()
        toDoView.endEditing(true)
    }
}

// MARK: - Setup current date
extension ToDoController {
    private func setLongCurrentDate() -> Date? {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy EEEE H:mm"
        return date
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
    }

    @objc
    private func keyboardDidHide() {
        toDoView.toDoTextView.contentInset = .zero
        setNavigationRightItem(isOn: false)
    }
}
