//
//  ListView.swift
//  Notes
//
//  Created by Антон Макаров on 08.04.2022.
//

import UIKit

class ListView: UIView {
    let titleLabel = UILabel()
    let toDoTableView = UITableView()
    var addButton = UIButton()

    var addButtonBottomConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
    }

    private func setViews() {
        self.backgroundColor = Colors.shared.viewBackround
        toDoTableView.register(ListCell.self, forCellReuseIdentifier: ListCell.reuseId)
        toDoTableView.separatorStyle = .none
        toDoTableView.showsVerticalScrollIndicator = false
        toDoTableView.backgroundColor = Colors.shared.viewBackround

        titleLabel.text = "Заметки"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: FontsLibrary.SFProTextSemibold.rawValue, size: 17)

        addButton.setImage(UIImage(named: "Plus"), for: .normal)
        addButton.clipsToBounds = true
        addButton.contentMode = .scaleAspectFill
        addButton.backgroundColor = .systemGreen
        addButton.titleLabel?.font = .systemFont(ofSize: 25, weight: .semibold)
    }

    private func setConstraints() {
        Helper.tamicOff(views: [toDoTableView, titleLabel, addButton])
        Helper.add(subviews: [toDoTableView, titleLabel], superView: self)
        Helper.add(subviews: [addButton], superView: toDoTableView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 57),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 130),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),

            toDoTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 26),
            toDoTableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            toDoTableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            toDoTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -9),

            addButton.rightAnchor.constraint(equalTo: toDoTableView.safeAreaLayoutGuide.rightAnchor, constant: -4),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.widthAnchor.constraint(equalToConstant: 50)
        ])

        addButtonBottomConstraint = NSLayoutConstraint(
            item: addButton,
            attribute: .bottom ,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1,
            constant: -60
        )
        self.addConstraint(addButtonBottomConstraint)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
