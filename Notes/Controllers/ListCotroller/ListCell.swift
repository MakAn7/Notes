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

    override func layoutSubviews() {
        super.layoutSubviews()
        for control in self.subviews {
            if control.isMember(of: NSClassFromString("UITableViewCellEditControl")!) {
                for view in control.subviews {
                    if view.isKind(of: UIImageView.self) {
                        guard let image = view as? UIImageView else { return }
                        if self.isSelected {
                            image.image = UIImage(named: "blueCircle")
                        } else {
                            image.image = UIImage(named: "grayCircle")
                        }
                    }
                }
            }
        }
    }

    private func setViews() {
        layer.borderWidth = 2
        layer.borderColor = Colors.shared.viewBackround?.cgColor
        layer.cornerRadius = 15
        layer.masksToBounds = true

        subContentView.backgroundColor = .white
        subContentView.layer.cornerRadius = 15
        subContentView.clipsToBounds = true

        contentView.addSubview(subContentView)

        headerLabel.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 16)

        dateLabel.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 10)

        descriptionLabel.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 10)
        descriptionLabel.textColor = Colors.shared.textColor

        selectionStyle = .gray
        backgroundConfiguration?.backgroundColor = .white
        backgroundConfiguration?.cornerRadius = 15
            }

    private func setConstraints() {
        Helper.tamicOff(views: [headerLabel, descriptionLabel, dateLabel, subContentView])
        Helper.add(subviews: [headerLabel, descriptionLabel, dateLabel], superView: subContentView)

        NSLayoutConstraint.activate([
            subContentView.topAnchor.constraint(equalTo: topAnchor),
            subContentView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            subContentView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            subContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),

            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            headerLabel.leftAnchor.constraint(equalTo: subContentView.leftAnchor, constant: 18),
            headerLabel.widthAnchor.constraint(equalToConstant: 250),
            headerLabel.heightAnchor.constraint(equalToConstant: 18),

            descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 3),
            descriptionLabel.leftAnchor.constraint(equalTo: subContentView.leftAnchor, constant: 18),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 326),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 14),

            dateLabel.leftAnchor.constraint(equalTo: subContentView.leftAnchor, constant: 18),
            dateLabel.heightAnchor.constraint(equalToConstant: 10),
            dateLabel.widthAnchor.constraint(equalToConstant: 68),
            dateLabel.bottomAnchor.constraint(equalTo: subContentView.bottomAnchor, constant: -7)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
