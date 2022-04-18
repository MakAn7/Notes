//
//  ListController.swift
//  Notes
//
//  Created by Антон Макаров on 08.04.2022.
//

import UIKit

class ListController: UIViewController, UpdateListDelegate {
    let listView = ListView()
    var todosArray: [ToDo] = [] {
        didSet {
            addCustomViewToStack()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = listView
        setupNavigationBar()
        updateViews()
        addTargets()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setupNavigationBar () {
        navigationItem.backButtonDisplayMode = .minimal
    }
    func updateViews() {
        todosArray = NoteSettings.shared.getArray()
    }

    private func addTargets() {
        listView.addButton.addTarget(self, action: #selector(addToDo), for: .touchUpInside)
    }

    private func addCustomViewToStack() {
        for view in listView.stack.arrangedSubviews {
            listView.stack.removeArrangedSubview(view)
        }

        for (indexToDo, todo) in todosArray.enumerated() {
            let cell = CustomView(
                frame: CGRect(),
                todo: todo) { [weak self](todo) in
                let toDoVC = ToDoController()
                toDoVC.todo = todo
                toDoVC.isNew = false
                toDoVC.indexToDo = indexToDo
                toDoVC.delegate = self
                toDoVC.modalPresentationStyle = .fullScreen
                self?.navigationController?.show(toDoVC, sender: nil)
            }
            cell.layer.cornerRadius = 14
            cell.clipsToBounds = true
            listView.stack.addArrangedSubview(cell)
        }
    }
    @objc
    private func addToDo() {
        let toDoVC = ToDoController()
        toDoVC.modalPresentationStyle = .fullScreen
        toDoVC.delegate = self
        navigationController?.show(toDoVC, sender: nil)
    }
}
