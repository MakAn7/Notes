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
    @objc
    private func addToDo() {
        let toDoVC = ToDoController()
        toDoVC.modalPresentationStyle = .fullScreen
        toDoVC.delegate = self
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
        cell.dateLabel.text = currentToDo.date
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        94
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDoVC = ToDoController()
        toDoVC.todo = todosArray[indexPath.row]
        toDoVC.indexToDo = indexPath.row
        toDoVC.isNew = false
        navigationController?.show(toDoVC, sender: nil)
    }
}
