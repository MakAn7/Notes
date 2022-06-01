//
//  ListView.swift
//  Notes
//
//  Created by Антон Макаров on 08.04.2022.
//

import UIKit

class ListView: UIView {
    let toDoTableView = UITableView()
    let addButton = UIButton()
    let activityIndicator = UIActivityIndicatorView()

    var addButtonBottomConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
    }

    private func setViews() {
        backgroundColor = Colors.shared.viewBackround
        toDoTableView.allowsMultipleSelectionDuringEditing = true
        toDoTableView.register(ListCell.self, forCellReuseIdentifier: ListCell.reuseId)
        toDoTableView.separatorStyle = .none
        toDoTableView.showsVerticalScrollIndicator = false
        toDoTableView.backgroundColor = Colors.shared.viewBackround

        addButton.setImage(UIImage(named: "Plus"), for: .normal)
        addButton.clipsToBounds = true
        addButton.contentMode = .scaleAspectFit
        addButton.titleLabel?.font = .systemFont(ofSize: 25, weight: .semibold)

        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.style = .large
        activityIndicator.color = .darkGray
    }

    private func setConstraints() {
        Helper.tamicOff(views: [toDoTableView, addButton, activityIndicator])
        Helper.add(subviews: [toDoTableView, activityIndicator], superView: self)
        Helper.add(subviews: [addButton], superView: toDoTableView)

        NSLayoutConstraint.activate([
            toDoTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            toDoTableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 14),
            toDoTableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            toDoTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -9),

            addButton.rightAnchor.constraint(equalTo: toDoTableView.safeAreaLayoutGuide.rightAnchor, constant: -6),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.widthAnchor.constraint(equalToConstant: 50),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
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
