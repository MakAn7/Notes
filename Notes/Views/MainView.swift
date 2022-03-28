//
//  MainView.swift
//  Notes
//
//  Created by Антон Макаров on 25.03.2022.
//

import UIKit

class MainView: UIView {
    
    let titleTextField = UITextField(placeholder: "Заголовок заметки")
    let noteTextView = UITextView()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setViews()
        setConstraints()
        
    }
    
    private func setViews() {
        
        titleTextField.font = .boldSystemFont(ofSize: 22)
        titleTextField.textAlignment = .center
        titleTextField.layer.cornerRadius = 8
        titleTextField.layer.borderWidth = 2
        titleTextField.layer.borderColor = UIColor.gray.cgColor
        titleTextField.backgroundColor = .lightGray.withAlphaComponent(0.1)
        
        noteTextView.font = .systemFont(ofSize: 14, weight: .regular)
        noteTextView.layer.cornerRadius = 8
        noteTextView.layer.borderColor = UIColor.gray.cgColor
        noteTextView.layer.borderWidth = 2
        noteTextView.backgroundColor = .lightGray.withAlphaComponent(0.2)

    }
    
    private func setConstraints() {
        
        let stackTF = UIStackView(arrangedSubviews: [titleTextField,noteTextView])
        stackTF.axis = .vertical
        stackTF.spacing = 20
        
        stackTF.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackTF)
       
        titleTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        NSLayoutConstraint.activate([
            stackTF.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 10),
            stackTF.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10),
            stackTF.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackTF.bottomAnchor.constraint(equalTo:safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
