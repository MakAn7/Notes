//
//  CustomImageView.swift
//  Notes
//
//  Created by Антон Макаров on 08.04.2022.
//

import UIKit

class CustomView: UIView {
    private var todo: ToDo
    private var tapCompletion: (ToDo) -> Void

    let headerLabel = UILabel()
    let descriptionLabel = UILabel()
    let dateLabel = UILabel()
    init(
        frame: CGRect,
        todo: ToDo,
        tapCompletion: @escaping (ToDo) -> Void
    ) {
        self.todo = todo
        self.tapCompletion = tapCompletion
        super.init(frame: frame)
        setViews()
        setConstraints()
        tapGestureToView()
        updateToDo()
    }
    private func tapGestureToView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tap)
    }
    @objc
    func didTap(_ sender: UITapGestureRecognizer) {
        tapCompletion(todo)
    }
    private func updateToDo() {
        headerLabel.text = todo.title
        dateLabel.text = todo.date
        descriptionLabel.text = todo.description
    }
    private func setViews() {
        backgroundColor = .white
        self.layer.cornerRadius = 14
        headerLabel.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 16)
        dateLabel.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 10)
        descriptionLabel.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 10)
        descriptionLabel.textColor = ColorsLibrary.textColor
    }
    private func setConstraints() {
        let stackTextLabel = UIStackView(
            views: [headerLabel, descriptionLabel],
            axis: .vertical,
            spacing: 10
        )
        stackTextLabel.alignment = .fill
        stackTextLabel.distribution = .fillProportionally

        let allStack = UIStackView(
            views: [stackTextLabel,
                    dateLabel],
            axis: .vertical,
            spacing: 24
        )
        allStack.alignment = .fill
        allStack.distribution = .fillProportionally

        Helper.tamicOff(views: [allStack])
        Helper.add(subviews: [allStack], superView: self)

        NSLayoutConstraint.activate([
            allStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            allStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            allStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            allStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
