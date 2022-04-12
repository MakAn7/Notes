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
        navigationItem.backButtonDisplayMode = .minimal
        view = listView
        updateViews()
        addTargets()
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
        for (index, todo) in todosArray.enumerated() {
            let cell = CustomView(todo: todo)
            let tap = TapWithTag(
                tag: index,
                target: self,
                action: #selector(updateToDo)
            )
            cell.addGestureRecognizer(tap)
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

    @objc
    private func updateToDo(_ sender: TapWithTag) {
        let toDoVC = ToDoController()
        toDoVC.modalPresentationStyle = .fullScreen
        toDoVC.todo = todosArray[sender.tag]
        toDoVC.isNew = false
        toDoVC.index = sender.tag
        toDoVC.delegate = self
        navigationController?.show(toDoVC, sender: nil)
    }
}
