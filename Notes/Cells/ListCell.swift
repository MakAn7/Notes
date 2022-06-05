//
//  ListCell.swift
//  Notes
//
//  Created by Антон Макаров on 04.06.2022.
//

import UIKit

class ListCell: UITableViewCell {
    static let reuseId = "ListCell"

    let subContentView = UIView()
    let headerLabel = UILabel()
    let descriptionLabel = UILabel()
    let dateLabel = UILabel()
    let activityIndicator = UIActivityIndicatorView()
    let iconImageView = UIImageView()

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
                        if self.isEditing {
                            image.frame = CGRect(x: 7, y: 5, width: 16, height: 16)
                            if self.isSelected {
                                image.image = UIImage(named: "blueCircle")
                            } else {
                                image.image = UIImage(named: "grayCircle")
                            }
                        } else {
                            image.isHidden = true
                        }
                    }
                }
            }
        }
//        if iconImageView.image != nil {
//            activityIndicator.stopAnimating()
//        }
    }

    private func setViews() {
        layer.backgroundColor = .none

        subContentView.backgroundColor = .clear
        subContentView.clipsToBounds = true

        contentView.addSubview(subContentView)

        headerLabel.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 16)

        dateLabel.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 10)

        descriptionLabel.font = UIFont(name: FontsLibrary.SFProTextMedium.rawValue, size: 10)
        descriptionLabel.textColor = Colors.shared.textColor

        selectionStyle = .gray
        backgroundConfiguration?.backgroundColor = .white
        backgroundConfiguration?.cornerRadius = 14
        backgroundConfiguration?.backgroundInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        iconImageView.backgroundColor = .clear
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = iconImageView.frame.height / 2

//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.style = .medium
//        activityIndicator.color = .systemBlue
    }

    private func setConstraints() {
        Helper.tamicOff(
            views:
                [headerLabel,
                 descriptionLabel,
                 dateLabel,
                 subContentView,
                 iconImageView
//                 activityIndicator
                ]
        )

        Helper.add(subviews: [headerLabel, descriptionLabel, dateLabel, iconImageView], superView: subContentView)
//        Helper.add(subviews: [activityIndicator], superView: iconImageView)
//        Helper.add(subviews: [headerLabel, descriptionLabel, dateLabel], superView: subContentView)

        NSLayoutConstraint.activate([
            subContentView.topAnchor.constraint(equalTo: topAnchor),
            subContentView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            subContentView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            subContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            headerLabel.leftAnchor.constraint(equalTo: subContentView.leftAnchor, constant: 18),
            headerLabel.widthAnchor.constraint(equalToConstant: 250),
            headerLabel.heightAnchor.constraint(equalToConstant: 18),

            descriptionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 3),
            descriptionLabel.leftAnchor.constraint(equalTo: subContentView.leftAnchor, constant: 18),
            descriptionLabel.rightAnchor.constraint(equalTo: subContentView.rightAnchor, constant: -20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 14),

            dateLabel.leftAnchor.constraint(equalTo: subContentView.leftAnchor, constant: 18),
            dateLabel.heightAnchor.constraint(equalToConstant: 11),
            dateLabel.widthAnchor.constraint(equalToConstant: 68),
            dateLabel.bottomAnchor.constraint(equalTo: subContentView.bottomAnchor, constant: -10),

            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.rightAnchor.constraint(equalTo: subContentView.rightAnchor, constant: -15),
            iconImageView.bottomAnchor.constraint(equalTo: subContentView.bottomAnchor, constant: -9)
//
//            activityIndicator.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor),
//            activityIndicator.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor)
        ])
    }

     func setContentToListCell(from viewModel: ListCellViewModel) {
        headerLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
         dateLabel.text = viewModel.date
     }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
