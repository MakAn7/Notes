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
        self.layer.cornerRadius = 14
        self.clipsToBounds = true
        backgroundColor = .white
        headerLabel.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 16)
        dateLabel.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 10)
        descriptionLabel.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 10)
        descriptionLabel.textColor = ColorsLibrary.textColor
    }
    private func setConstraints() {
        Helper.tamicOff(views: [headerLabel, descriptionLabel, dateLabel])
        Helper.add(subviews: [headerLabel, descriptionLabel, dateLabel], superView: self)

        self.heightAnchor.constraint(equalToConstant: 90).isActive = true

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            headerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            headerLabel.widthAnchor.constraint(equalToConstant: 300),
            headerLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 3),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 326),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 14)
        ])
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            dateLabel.heightAnchor.constraint(equalToConstant: 10),
            dateLabel.widthAnchor.constraint(equalToConstant: 68),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
