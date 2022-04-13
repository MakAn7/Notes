//
//  MainView.swift
//  Notes
//
//  Created by Антон Макаров on 25.03.2022.
//

import UIKit

class ToDoView: UIView {
    let titleTextField = UITextField()
    let noteTextView = UITextView()
    let dateTextField = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setViews()
        setConstraints()
    }
    private func setViews() {
        self.backgroundColor = ColorsLibrary.viewBackgroundColor
        noteTextView.font = UIFont(name: FontsLibrary.SFProTextRegular.rawValue, size: 16)
        noteTextView.backgroundColor = ColorsLibrary.viewBackgroundColor

        dateTextField.textColor = ColorsLibrary.textColor
        dateTextField.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 14)
        dateTextField.textAlignment = .center
        dateTextField.isUserInteractionEnabled = false

        titleTextField.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 24)
        titleTextField.attributedPlaceholder = NSAttributedString(
        string: "Введите название",
        attributes: [NSAttributedString.Key.font: UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 24) ?? ""]
        )
    }

    private func setConstraints() {
        let stackTF = UIStackView(arrangedSubviews: [dateTextField, titleTextField])
        stackTF.axis = .vertical
        stackTF.spacing = 5
        Helper.tamicOff(views: [stackTF, noteTextView])
        Helper.add(subviews: [stackTF, noteTextView], superView: self)

        titleTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true

        NSLayoutConstraint.activate([
            stackTF.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            stackTF.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10),
            stackTF.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackTF.heightAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            noteTextView.topAnchor.constraint(equalTo: stackTF.bottomAnchor, constant: 10),
            noteTextView.rightAnchor.constraint(equalTo: rightAnchor),
            noteTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noteTextView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
