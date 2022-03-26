//
//  ViewController.swift
//  Notes
//
//  Created by Антон Макаров on 25.03.2022.
//

import UIKit

class MainController: UIViewController {
    
    private let defaults = UserDefaults.standard
    
    let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        mainView.noteTextView.becomeFirstResponder()
        addTarget()
        getNote()
    }
    
    private func addTarget() {
        mainView.completedButton.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
    }
    
    private func getNote() {
        mainView.titleTextField.text = NoteSettings.title
        mainView.noteTextView.text = NoteSettings.description
    }
    
    @objc
    private func saveNote() {
        
        guard let titleText = mainView.titleTextField.text else { return }
        NoteSettings.title = titleText
        
        guard let descriptionText = mainView.noteTextView.text else { return }
        NoteSettings.description = descriptionText
        
        mainView.endEditing(true)
    }
}


