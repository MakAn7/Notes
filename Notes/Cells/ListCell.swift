//
//  ListCell.swift
//  Notes
//
//  Created by Антон Макаров on 18.04.2022.
//

import UIKit

class ListCell: UITableViewCell {
    static let reuseId = "ListCell"

    let subContentView = UIView()
    let headerLabel = UILabel()
    let descriptionLabel = UILabel()
    let dateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }

    private func setViews() {
        subContentView.backgroundColor = .white
        subContentView.layer.cornerRadius = 14
        subContentView.clipsToBounds = true

        contentView.addSubview(subContentView)

        headerLabel.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 16)

        dateLabel.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 10)

        descriptionLabel.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 10)
        descriptionLabel.textColor = ColorsLibrary.textColor

        selectionStyle = .none
        backgroundColor = .clear
    }
    private func setConstraints() {
        Helper.tamicOff(views: [headerLabel, descriptionLabel, dateLabel, subContentView])
        Helper.add(subviews: [headerLabel, descriptionLabel, dateLabel], superView: subContentView)

        NSLayoutConstraint.activate([
            subContentView.topAnchor.constraint(equalTo: topAnchor),
            subContentView.leftAnchor.constraint(equalTo: leftAnchor),
            subContentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            subContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])

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
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
