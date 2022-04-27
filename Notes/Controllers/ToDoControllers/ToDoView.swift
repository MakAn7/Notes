//
//  MainView.swift
//  Notes
//
//  Created by Антон Макаров on 25.03.2022.
//

import UIKit

class ToDoView: UIView {
    let titleTextField = UITextField()
    let toDoTextView = UITextView()
    let dateTextField = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setViews()
        setConstraints()
    }

    private func setViews() {
        self.backgroundColor = Colors.shared.viewBackround
        toDoTextView.font = UIFont(name: FontsLibrary.SFProTextRegular.rawValue, size: 16)
        toDoTextView.backgroundColor = Colors.shared.viewBackround
        toDoTextView.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        toDoTextView.autocorrectionType = .no
        toDoTextView.spellCheckingType = .no

        dateTextField.textColor = Colors.shared.textColor
        dateTextField.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 14)
        dateTextField.textAlignment = .center
        dateTextField.isUserInteractionEnabled = false

        titleTextField.autocorrectionType = .no
        titleTextField.spellCheckingType = .no
        titleTextField.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 24)
        titleTextField.attributedPlaceholder = NSAttributedString(
        string: "Введите название",
        attributes: [NSAttributedString.Key.font: UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 24) ?? ""]
        )
    }

    private func setConstraints() {
        Helper.tamicOff(views: [dateTextField, titleTextField, toDoTextView])
        Helper.add(subviews: [dateTextField, titleTextField, toDoTextView], superView: self)

        NSLayoutConstraint.activate([
            dateTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            dateTextField.widthAnchor.constraint(equalToConstant: 350),
            dateTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateTextField.heightAnchor.constraint(equalToConstant: 16),

            titleTextField.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 22),
            titleTextField.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            titleTextField.heightAnchor.constraint(equalToConstant: 24),
            titleTextField.widthAnchor.constraint(equalToConstant: 300),

            toDoTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 9),
            toDoTextView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            toDoTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            toDoTextView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
