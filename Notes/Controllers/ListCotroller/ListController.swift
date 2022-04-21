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
            listView.toDoTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = listView
        setupNavigationBar()
        updateViews()
        addTargets()
        listView.toDoTableView.delegate = self
        listView.toDoTableView.dataSource = self
    }

    private func setupNavigationBar () {
        navigationItem.backButtonDisplayMode = .minimal
    }

    func updateViews() {
        todosArray = ToDoSettings.shared.fetchArray()
    }
    private func addTargets() {
        listView.addButton.addTarget(self, action: #selector(addToDo), for: .touchUpInside)
    }
    @objc
    private func addToDo() {
        let toDoVC = ToDoController(state: .new, delegate: self)
        toDoVC.modalPresentationStyle = .fullScreen
        navigationController?.show(toDoVC, sender: nil)
    }
}

extension ListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todosArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListCell.reuseId,
            for: indexPath
        ) as? ListCell else {
            fatalError("Don't get cell")
        }
        let currentToDo = todosArray[indexPath.row]
        cell.headerLabel.text = currentToDo.title
        cell.descriptionLabel.text = currentToDo.description
        guard let date = currentToDo.date else {
            fatalError("\(#function) Don't get Date ")
        }
        cell.dateLabel.text = convertDateToString(date: date, short: true)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        94
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDoVC = ToDoController(
            state: .edit(
            todo: todosArray[indexPath.row],
            index: indexPath.row
            ),
            delegate: self
        )
        navigationController?.show(toDoVC, sender: nil)
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Удалить") { (_, _, _) in
            ToDoSettings.shared.removeToDo(indexToDo: indexPath.row)
            self.todosArray.remove(at: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
