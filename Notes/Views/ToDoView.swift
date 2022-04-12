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
        self.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        noteTextView.font = UIFont(name: "SFProText-Regular", size: 16)
        noteTextView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)

        dateTextField.textColor = UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1)
        dateTextField.font = UIFont(name: "SFProText-Medium", size: 14)
        dateTextField.textAlignment = .center
        dateTextField.isUserInteractionEnabled = false

        titleTextField.font = UIFont(name: "SFProText-Medium", size: 24)
        titleTextField.attributedPlaceholder = NSAttributedString(
            string: "Введите название",
            attributes: [NSAttributedString.Key.font: UIFont(name: "SFProText-Medium", size: 24) ?? ""]
        )
    }

    private func setConstraints() {
        let stackTF = UIStackView(arrangedSubviews: [dateTextField, titleTextField])
        stackTF.axis = .vertical
        stackTF.spacing = 5

        stackTF.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackTF)
        titleTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true

        NSLayoutConstraint.activate([
            stackTF.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            stackTF.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10),
            stackTF.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackTF.heightAnchor.constraint(equalToConstant: 100)
        ])
        addSubview(noteTextView)
        NSLayoutConstraint.activate([
            noteTextView.topAnchor.constraint(equalTo: stackTF.bottomAnchor, constant: 10),
            noteTextView.rightAnchor.constraint(equalTo: rightAnchor),
            noteTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noteTextView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        noteTextView.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
