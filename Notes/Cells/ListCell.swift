//
//  CustomImageView.swift
//  Notes
//
//  Created by Антон Макаров on 08.04.2022.
//

import UIKit

class ListCell: UITableViewCell {
    static let reuseId = "ListCell"

    lazy var subbbView = UIView()
    let headerLabel = UILabel()
    let descriptionLabel = UILabel()
    let dateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    private func setViews() {
        subbbView.backgroundColor = .white
        subbbView.layer.cornerRadius = 14
        subbbView.clipsToBounds = true
        contentView.addSubview(subbbView)
        headerLabel.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 16)
        dateLabel.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 10)
        descriptionLabel.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 10)
        descriptionLabel.textColor = ColorsLibrary.textColor
        selectionStyle = .none
        backgroundColor = .clear
    }
    private func setConstraints() {
        Helper.tamicOff(views: [headerLabel, descriptionLabel, dateLabel, subbbView])
        Helper.add(subviews: [headerLabel, descriptionLabel, dateLabel], superView: subbbView)
        NSLayoutConstraint.activate([
            subbbView.topAnchor.constraint(equalTo: topAnchor),
            subbbView.leftAnchor.constraint(equalTo: leftAnchor),
            subbbView.centerXAnchor.constraint(equalTo: centerXAnchor),
            subbbView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
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
