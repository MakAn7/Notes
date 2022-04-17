//
//  ListView.swift
//  Notes
//
//  Created by Антон Макаров on 08.04.2022.
//

import UIKit

class ListView: UIView {
    let titleLabel = UILabel()
    var scrollView = UIScrollView()
    let stack = UIStackView()
    var addButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
    }

    private func setViews() {
        self.backgroundColor = ColorsLibrary.viewBackgroundColor
        titleLabel.text = "Заметки"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: FontsLibrary.SFProTextSemibold.rawValue, size: 17)

        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 4

        addButton.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        addButton.layer.cornerRadius = addButton.layer.frame.height / 2
        addButton.setImage(UIImage(named: "Plus"), for: .normal)
        addButton.clipsToBounds = true
        addButton.contentVerticalAlignment = .center
        addButton.tintColor = .white
        addButton.titleLabel?.font = .systemFont(ofSize: 25, weight: .semibold)
        addButton.layer.cornerRadius = 25
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
    }
      func setConstraints() {
        Helper.tamicOff(views: [scrollView, titleLabel, stack, addButton])
        Helper.add(subviews: [scrollView, titleLabel], superView: self)
        Helper.add(subviews: [stack, addButton], superView: scrollView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 57),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 130),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            scrollView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            scrollView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -9)
        ])
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 24),
            stack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -25),
            stack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            addButton.rightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.rightAnchor, constant: -3),
            addButton.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor, constant: -17),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
