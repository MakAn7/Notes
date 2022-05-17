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
            if todosArray.count >= oldValue.count {
                listView.toDoTableView.reloadData()
            }
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
            action: #selector(updateStateRightButton)
        )
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(
            [.font: UIFont(name: FontsLibrary.SFProTextRegular.rawValue, size: 17) ?? ""], for: .normal
        )
    }

    @objc
    func updateStateRightButton () {
        if todosArray.count >= 1 && listView.toDoTableView.isEditing == false {
            listView.toDoTableView.setEditing(true, animated: true)
            UIView.transition(
                with: listView.addButton,
                duration: 1,
                options: .transitionCrossDissolve
            ) {
                self.listView.addButton.setImage(UIImage(named: "Box"), for: .normal)
                self.navigationItem.rightBarButtonItem?.title = "Готово"
            }
        } else {
            UIView.transition(
                with: listView.addButton,
                duration: 0.4,
                options: .transitionFlipFromBottom
            ) {
                self.listView.addButton.setImage(UIImage(named: "Plus"), for: .normal)
                self.listView.toDoTableView.setEditing(false, animated: true)
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
        if let indexRow = tableView.indexPathsForSelectedRows {
            selectRows = indexRow
        }
    }

    @objc
    private func addOrRemoveToDo() {
        if listView.toDoTableView.isEditing {
            if selectRows.isEmpty {
                alertShowError(message: "Вы не выбрали ни одной заметки .", title: "Внимание .")
            }
            selectRows.sort { $0.row > $1.row }
            for indexPath in selectRows {
                ToDoSettings.shared.removeToDo(indexToDo: indexPath.row)
                updateViews()
                listView.toDoTableView.beginUpdates()
                listView.toDoTableView.deleteRows(
                    at: [IndexPath(row: indexPath.row, section: 0)],
                    with: .top
                )
                listView.toDoTableView.endUpdates()
                listView.toDoTableView.setEditing(false, animated: true)
                navigationItem.rightBarButtonItem?.title = "Выбрать"
                listView.addButton.setImage(UIImage(named: "Plus"), for: .normal)
                selectRows.removeAll()
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
        let delete = UIContextualAction(style: .destructive, title: nil) { (_, _, _) in
            ToDoSettings.shared.removeToDo(indexToDo: indexPath.row)
            self.todosArray.remove(at: indexPath.row)
            self.listView.toDoTableView.reloadData()
        }
        delete.backgroundColor = Colors.shared.viewBackround
        delete.image = UIImage(named: "trash")
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: Animations
extension ListController {
    func showAddButtonWithAnimation() {
        listView.addButton.layer.cornerRadius = listView.addButton.frame.width / 2
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.listView.addButtonBottomConstraint.constant -= self.view.bounds.height
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.springAnimationWithAddButton()
            }
        )
    }

    func tapAddButtonWithAnimation() {
        UIView.animate(withDuration: 1.5) {
            self.listView.addButtonBottomConstraint.constant -= self.listView.addButton.frame.height
            self.view.layoutIfNeeded()
        }
        UIView.animate(
            withDuration: 0.5,
            delay: 0.5,
            options: .curveEaseIn,
            animations: {
                self.listView.addButtonBottomConstraint.constant += self.view.frame.height
                self.view.layoutIfNeeded()
            }, completion: { _ in
                let toDoVC = ToDoController(state: .new, delegate: self)
                toDoVC.modalPresentationStyle = .fullScreen
                self.navigationController?.show(toDoVC, sender: nil)
            }
        )
    }

    func springAnimationWithAddButton() {
        let frame = listView.addButton.frame
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.1,
            initialSpringVelocity: 5,
            options: [.allowUserInteraction, .curveEaseOut],
            animations: {
                self.listView.addButton.frame = CGRect(
                    x: frame.origin.x,
                    y: frame.origin.y - 15,
                    width: frame.width ,
                    height: frame.height
                )
            }
        )
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: [.curveEaseOut],
            animations: {
                self.listView.addButton.frame.origin.y += 15
            }
        )
    }
}
