//
//  DetailsToDoViewController.swift
//  Notes
//
//  Created by Антон Макаров on 05.06.2022.
//
//
import UIKit

protocol DetailsToDoDisplayLogic: AnyObject {
    func displayData()
}

class DetailsToDoViewController: UIViewController {
    enum State {
        case new
        case edit(model: ListCellViewModel, indexRow: Int)
    }
    let titleTextField = UITextField()
    let toDoTextView = UITextView()
    let dateTextField = UITextField()

    var interactor: DetailsToDoBusinessLogic?
    var router: DetailsToDoRoutingLogic?
    weak var delegate: setupConstaraintsDelegate?

    var model: ListCellViewModel!
    var state: State!
    var indexRow: Int!

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    init(state: State, delegate: setupConstaraintsDelegate) {
        self.state = state
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)

        switch state {
        case .new:
            model = ListCellViewModel(title: "", description: "", date: .now, iconUrl: nil)
        case .edit(model: let model, indexRow: let indexRow):
            self.model = model
            self.indexRow = indexRow
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
        didSetContentToViews()
        registerKeybordNotification()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
        updateModelAtDataBase()
    }

    // MARK: - Set Views
    private func setViews() {
        view.backgroundColor = Colors.shared.viewBackround
        toDoTextView.font = UIFont(name: FontsLibrary.SFProTextRegular.rawValue, size: 16)
        toDoTextView.becomeFirstResponder()
        toDoTextView.backgroundColor = Colors.shared.viewBackround
        toDoTextView.autocorrectionType = .no
        toDoTextView.spellCheckingType = .no
        toDoTextView.textContainer.lineFragmentPadding = 15

        dateTextField.textColor = Colors.shared.textColor
        dateTextField.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 14)
        dateTextField.textAlignment = .center
        dateTextField.isUserInteractionEnabled = false

        titleTextField.autocorrectionType = .no
        titleTextField.spellCheckingType = .no
        titleTextField.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 24)
        titleTextField.attributedPlaceholder = NSAttributedString(
            string: "Введите название",
            attributes: [NSAttributedString.Key.font: UIFont(
                name: FontsLibrary.SFProTextMedium.rawValue,
                size: 24
            ) ?? ""]
        )
    }

    // MARK: - Set Constraints
    private func setConstraints() {
        Helper.tamicOff(views: [dateTextField, titleTextField, toDoTextView])
        Helper.add(subviews: [dateTextField, titleTextField, toDoTextView], superView: view)

        NSLayoutConstraint.activate([
            dateTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            dateTextField.widthAnchor.constraint(equalToConstant: 350),
            dateTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateTextField.heightAnchor.constraint(equalToConstant: 16),

            titleTextField.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 22),
            titleTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            titleTextField.heightAnchor.constraint(equalToConstant: 26),
            titleTextField.widthAnchor.constraint(equalToConstant: 300),

            toDoTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 7),
            toDoTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            toDoTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toDoTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Set Content To Views
    private func didSetContentToViews() {
        titleTextField.text = model.title
        toDoTextView.text = model.description
        if let date = model.date {
            dateTextField.text = convertDateToString(date: date, short: false)
        }
    }

    // MARK: - Set Navigation Right Item
    private func setNavigationRightItem(isOn: Bool) {
        if isOn {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Готово",
                style: .plain,
                target: self,
                action: #selector(updateModel)
            )
            navigationItem.rightBarButtonItem?.setTitleTextAttributes(
                [.font: UIFont(name: FontsLibrary.SFProTextRegular.rawValue, size: 17) ?? ""], for: .normal
            )
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }

    @objc
    private func updateModel() {
        model = createModel()
        view.endEditing(true)
    }

    private func updateModelAtDataBase() {
        delegate?.setupConstraintToAddButton()
        if let newModel = createModel() {
            switch state {
            case .new:
                interactor?.pushModelAtArray(model: newModel)
            case .edit:
                interactor?.updateModelAtArray(model: newModel, indexModel: indexRow)
            case .none:
                fatalError("state .none case")
            }
        }
        view.endEditing(true)
    }

    private func createModel() -> ListCellViewModel? {
        let titleText = titleTextField.text ?? ""
        let descriptionText = toDoTextView.text ?? ""

        let model = ListCellViewModel(
            title: titleText,
            description: descriptionText,
            date: model.date,
            iconUrl: model.iconUrl
        )

        if model.isEmpty {
            self.isMovingFromParent ? nil :
            alertShowError(message: "Заполните заголовок и поле заметки .", title: nil)
            return nil
        }
        let currentToDo = ListCellViewModel(
            title: titleText,
            description: descriptionText,
            date: setLongCurrentDate(),
            iconUrl: model.iconUrl
        )
        return currentToDo
    }
}

extension DetailsToDoViewController: DetailsToDoDisplayLogic {
    func displayData() {
    }
}

// MARK: - Setup current date
extension DetailsToDoViewController {
    private func setLongCurrentDate() -> Date? {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy EEEE H:mm"
        return date
    }
}

// MARK: - Setup settings with keyboard
extension DetailsToDoViewController {
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
        toDoTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrameSize.height, right: 0)
        toDoTextView.scrollIndicatorInsets = toDoTextView.contentInset
        toDoTextView.scrollRangeToVisible(toDoTextView.selectedRange)
        toDoTextView.autocorrectionType = .no
        titleTextField.autocorrectionType = .no
        titleTextField.spellCheckingType = .no
        setNavigationRightItem(isOn: true)
    }

    @objc
    private func keyboardDidHide() {
        toDoTextView.contentInset = .zero
        setNavigationRightItem(isOn: false)
    }
}
