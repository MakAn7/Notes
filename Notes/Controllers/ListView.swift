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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
    }

    private func setViews() {
        toDoTableView.register(ListCell.self, forCellReuseIdentifier: ListCell.reuseId)
        toDoTableView.separatorStyle = .none
        toDoTableView.showsVerticalScrollIndicator = false
        toDoTableView.backgroundColor = ColorsLibrary.viewBackgroundColor
        self.backgroundColor = ColorsLibrary.viewBackgroundColor
        titleLabel.text = "Заметки"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: FontsLibrary.SFProTextSemibold.rawValue, size: 17)

        addButton.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        addButton.layer.cornerRadius = addButton.layer.frame.height / 2
        addButton.setImage(UIImage(named: "Plus"), for: .normal)
        addButton.clipsToBounds = true
        addButton.contentVerticalAlignment = .center
        addButton.tintColor = .white
        addButton.titleLabel?.font = .systemFont(ofSize: 25, weight: .semibold)
        addButton.layer.cornerRadius = 25
    }
      func setConstraints() {
        Helper.tamicOff(views: [toDoTableView, titleLabel, addButton])
        Helper.add(subviews: [toDoTableView, titleLabel], superView: self)
        Helper.add(subviews: [addButton], superView: toDoTableView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 57),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 130),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
        NSLayoutConstraint.activate([
            toDoTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 26),
            toDoTableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            toDoTableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            toDoTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -9)
        ])
        NSLayoutConstraint.activate([
            addButton.rightAnchor.constraint(equalTo: toDoTableView.safeAreaLayoutGuide.rightAnchor, constant: -3),
            addButton.bottomAnchor.constraint(equalTo: toDoTableView.safeAreaLayoutGuide.bottomAnchor, constant: -17),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
