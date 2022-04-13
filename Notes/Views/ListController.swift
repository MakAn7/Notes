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
            let cell = CustomView(frame: CGRect(x: 0, y: 0, width: 358, height: 90), todo: todo) { (todo) in
                let toDoVC = ToDoController()
                toDoVC.todo = todo
                toDoVC.isNew = false
                toDoVC.index = index
                toDoVC.delegate = self
                toDoVC.modalPresentationStyle = .fullScreen
                self.navigationController?.show(toDoVC, sender: nil)
            }
            let tap = UITapGestureRecognizer(target: self, action: #selector(cell.didTap))
            cell.addGestureRecognizer(tap)
            cell.isUserInteractionEnabled = true
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
    //            let tap = TapWithTag(
    //                tag: index,
    //                target: self,
    //                action: nil
    //            )
//    @objc
//    private func updateToDo(_ sender: TapWithTag) {
//        let toDoVC = ToDoController()
//        toDoVC.modalPresentationStyle = .fullScreen
//        toDoVC.todo = todosArray[sender.tag]
//        toDoVC.isNew = false
//        toDoVC.index = sender.tag
//        toDoVC.delegate = self
//        navigationController?.show(toDoVC, sender: nil)
//    }
}
