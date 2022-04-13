//
//  CustomImageView.swift
//  Notes
//
//  Created by Антон Макаров on 08.04.2022.
//

import UIKit

// class NoteView: UIView {
//    private var note: Note
//    private var tapCompletion: (Note)->()
//
//    init(
//        frame: CGRect,
//        note: Note,
//        tapCompletion: @escaping (Note)->()
//    ) {
//        self.note = note
//        self.tapCompletion = tapCompletion
//        super.init(frame: frame)
//        configure()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError()
//    }
//
//    func didTap() {
//        tapCompletion(note)
//    }
//
//    func configure() { }
// }

class CustomView: UIView {
    private var todo: ToDo
    private var tapCompletion: (ToDo) -> Void

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
        }
    @objc
    func didTap() {
        tapCompletion(todo)
    }
    let headerLabel = UILabel()
    let descriptionLabel = UILabel()
    let dateLabel = UILabel()

    private func setViews() {
        backgroundColor = .white
        self.layer.cornerRadius = 14
        dateLabel.font = UIFont(name: "SFProText-Medium", size: 10)
        headerLabel.font = UIFont(name: "SFProText-Medium", size: 16)
        descriptionLabel.font = UIFont(name: "SFProText-Medium", size: 10)
        descriptionLabel.textColor = UIColor(red: 0.675, green: 0.675, blue: 0.675, alpha: 1)
        dateLabel.text = todo.date
        descriptionLabel.text = todo.description
        headerLabel.text = todo.title
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
        allStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(allStack)
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
