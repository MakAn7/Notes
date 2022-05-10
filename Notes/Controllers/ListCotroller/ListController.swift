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
    var selectRows = [IndexPath]()

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
            action: #selector(updateSelectRightButton)
        )
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(
            [.font: UIFont(name: FontsLibrary.SFProTextRegular.rawValue, size: 17) ?? ""], for: .normal
        )
    }

    @objc
    func updateSelectRightButton () {
        if !todosArray.isEmpty && !listView.toDoTableView.isEditing {
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

    func updateConstraints() {
        listView.addButtonBottomConstraint.constant  = -60
    }

    private func addTargets() {
        listView.addButton.addTarget(self, action: #selector(addOrRemoveToDo), for: .touchUpInside)
    }

    private func didSelectAndDeselectMultipleRows(tableView: UITableView, indexPath: IndexPath) {
        selectRows.removeAll()
        guard let indexRow = tableView.indexPathsForSelectedRows else { return }
        selectRows = indexRow
    }

    @objc
    private func addOrRemoveToDo() {
        if listView.toDoTableView.isEditing {
            switch selectRows.count {
            case  0:
                alertShowError(message: "Вы не выбрали ни одной заметки", title: "Внимание")
            default :
                selectRows.sort { $0.row > $1.row }
                for indexPath in selectRows {
                    ToDoSettings.shared.removeToDo(indexToDo: indexPath.row)
                    todosArray.remove(at: indexPath.row)
                    listView.toDoTableView.setEditing(false, animated: true)
                    navigationItem.rightBarButtonItem?.title = "Выбрать"
                    listView.addButton.setImage(UIImage(named: "Plus"), for: .normal)
                }
            }
        } else {
        tapAddButtonWithAnimation()
    }
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
        if !tableView.isEditing {
        let toDoVC = ToDoController(
            state: .edit(
                todo: todosArray[indexPath.row],
                index: indexPath.row
            ),
            delegate: self
        )
        navigationController?.show(toDoVC, sender: nil)
        } else {
            didSelectAndDeselectMultipleRows(tableView: tableView, indexPath: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
          didSelectAndDeselectMultipleRows(tableView: tableView, indexPath: indexPath)
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
            withDuration: 1,
            delay: 0,
            options: .curveEaseOut
        ) { [weak self] in
            guard let self = self else { return }
            self.listView.addButtonBottomConstraint.constant -= self.view.bounds.height
            self.view.layoutIfNeeded()
        } completion: { _ in
            UIView.animate(
                withDuration: 0.8,
                delay: 0.1,
                usingSpringWithDamping: 0.1,
                initialSpringVelocity: 0.1,
                options: [.allowUserInteraction]
            ) {
                self.listView.addButton.transform = CGAffineTransform(
                    scaleX: 0.8,
                    y: 0.8
                )
            } completion: { _ in
                UIView.animate(
                    withDuration: 0.25,
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
        UIView.animate(withDuration: 1.5) {
            self.listView.addButtonBottomConstraint.constant -= self.listView.addButton.frame.height
            self.view.layoutIfNeeded()
        }
        UIView.animate(
            withDuration: 0.7,
            delay: 0.7,
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
// MARK: - Info Alert
extension ListController {
    func alertShowError(message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
