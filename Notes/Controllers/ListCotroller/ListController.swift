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
        listView.addButtonBottomConstraint.constant += view.bounds.height
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAddButtonWithAnimation()
    }

    private func setupNavigationBar () {
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Выбрать",
            style: .plain,
            target: self,
            action: #selector(updateSelectButton)
        )
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(
            [.font: UIFont(name: FontsLibrary.SFProTextRegular.rawValue, size: 17) ?? ""], for: .normal
        )
    }

    @objc
    func updateSelectButton () {
        if !listView.toDoTableView.isEditing {
            listView.toDoTableView.setEditing(true, animated: true)
            UIView.transition(
                with: listView.addButton,
                duration: 1,
                options: .transitionCrossDissolve
            ) {
                self.listView.addButton.setImage(UIImage(named: "Box"), for: .normal)
            } completion: { _ in
                self.navigationItem.rightBarButtonItem?.title = "Готово"
            }
        } else {
            UIView.transition(
                with: listView.addButton,
                duration: 1,
                options: .transitionFlipFromBottom
            ) {
                self.listView.addButton.setImage(UIImage(named: "Plus"), for: .normal)
                self.listView.toDoTableView.isEditing = false
            } completion: { _ in
                self.navigationItem.rightBarButtonItem?.title = "Выбрать"
            }
        }
    }

    func updateViews() {
        todosArray = ToDoSettings.shared.fetchArray()
    }

    private func addTargets() {
        listView.addButton.addTarget(self, action: #selector(addToDo), for: .touchUpInside)
    }

    @objc
    private func addToDo() {
        tapAddButtonWithAnimation()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
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
        print(#function)
        let toDoVC = ToDoController(
            state: .edit(
                todo: todosArray[indexPath.row],
                index: indexPath.row
            ),
            delegate: self
        )
        navigationController?.show(toDoVC, sender: nil)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(#function)
    }

    func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath
    ) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            ToDoSettings.shared.removeToDo(indexToDo: indexPath.row)
            todosArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else {
            print("123333")
        }
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

// MARK: Animations
extension ListController {
    func showAddButtonWithAnimation() {
        listView.addButton.layer.cornerRadius = listView.addButton.frame.width / 2
        UIView.animate(
            withDuration: 2,
            delay: 0,
            options: .curveEaseOut
        ) { [weak self] in
            guard let self = self else { return }
            self.listView.addButtonBottomConstraint.constant -= self.view.bounds.height
            self.view.layoutIfNeeded()
        } completion: { _ in
            UIView.animate(
                withDuration: 1,
                delay: 0.5,
                options: [.curveEaseInOut]
            ) {
                self.listView.addButton.transform = CGAffineTransform(
                    scaleX: 0.7,
                    y: 0.7
                )
            } completion: { _ in
                UIView.animate(
                    withDuration: 1,
                    delay: 0,
                    options: .curveEaseInOut
                ) {
                    self.listView.addButton.transform = CGAffineTransform(
                        scaleX: 1,
                        y: 1
                    )
                }
            }
        }
    }

    func tapAddButtonWithAnimation() {
        UIView.animate(withDuration: 2) {
            self.listView.addButtonBottomConstraint.constant -= self.listView.addButton.frame.height
            self.view.layoutIfNeeded()
        }
        UIView.animate(
            withDuration: 1,
            delay: 1,
            options: .curveEaseIn
        ) {
            self.listView.addButtonBottomConstraint.constant += self.view.frame.height
            self.view.layoutIfNeeded()
        } completion: { _ in
            let toDoVC = ToDoController(state: .new, delegate: self)
            toDoVC.modalPresentationStyle = .fullScreen
            self.navigationController?.show(toDoVC, sender: nil)
        }
    }
}
