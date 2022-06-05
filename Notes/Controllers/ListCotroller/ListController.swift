//
//  ListController.swift
//  Notes
//
//  Created by Антон Макаров on 08.04.2022.
//

import UIKit

class ListController: UIViewController {
    let listView = ListView()
    var allTodos: [ToDo] = []
    var todosFromAPI: [ToDo] = []
    var todosFromUserDefault: [ToDo] = []

    init() {
        print("init - \(ListController.self)")
        super.init(nibName: nil, bundle: nil)
    }

    deinit {
        print("deinit - \(ListController.self)")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var selectRows = [IndexPath]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Заметки"
        view = listView
        setupNavigationBar()
        addTargets()
        listView.toDoTableView.delegate = self
        listView.toDoTableView.dataSource = self
        fetchToDosFromUserDefault()
        fetchTodos(url: getURL())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listView.addButtonBottomConstraint.constant += view.bounds.height
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAddButtonWithAnimation()
    }

    fileprivate func getURL() -> String? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "firebasestorage.googleapis.com"
        component.path = "/v0/b/ios-test-ce687.appspot.com/o/lesson8.json"
        component.queryItems = [
            URLQueryItem(name: "alt", value: "media"),
            URLQueryItem(name: "token", value: "215055df-172d-4b98-95a0-b353caca1424")
        ]
        return component.string
    }

    private func fetchTodos(url: String?) {
        listView.activityIndicator.isHidden = false
        listView.activityIndicator.startAnimating()
        Worker.shared.fetchToDos(
            dataType: ToDo.self,
            from: url,
            // блок замыкания локальный. слабую или безхозную ссылку ставить не надо.
            onSuccess: {
                self.todosFromAPI = $0
                self.allTodos = self.todosFromUserDefault + $0
                self.listView.toDoTableView.reloadData()
                self.listView.activityIndicator.stopAnimating()
            },
            onError: { print($0.localizedDescription)
            }
        )
    }

    private func setupNavigationBar () {
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Выбрать",
            style: .plain,
            target: self,
            action: #selector(updateStateRightAndAddButtons)
        )
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(
            [.font: UIFont(name: FontsLibrary.SFProTextRegular.rawValue, size: 17) ?? ""], for: .normal
        )
    }

    @objc
    func updateStateRightAndAddButtons () {
        changeTitleFromButtonsWithAnimation()
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
                allTodos.remove(at: indexPath.row)
                listView.toDoTableView.beginUpdates()
                listView.toDoTableView.deleteRows(
                    at: [IndexPath(row: indexPath.row, section: 0)],
                    with: .top
                )
                listView.toDoTableView.endUpdates()
                ToDoSettings.shared.removeToDo(indexToDo: indexPath.row)
            }
            listView.toDoTableView.setEditing(false, animated: true)
            navigationItem.rightBarButtonItem?.title = "Выбрать"
            listView.addButton.setImage(UIImage(named: "Plus"), for: .normal)
            selectRows.removeAll()
        } else {
            tapAddButtonWithAnimation()
        }
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allTodos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListCell.reuseId,
            for: indexPath
        ) as? ListCell else {
            fatalError("Don't get cell")
        }
            cell.setContentToListCell(from: allTodos[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        94
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !tableView.isEditing {
            let toDoVC = ToDoController(
                state: .edit(
                    todo: allTodos[indexPath.row],
                    index: indexPath.row
                ),
                delegate: self
            )
            // deinit ListController не сработает при переходе,
            // потому что контроллер не выгрузится из памяти, а ToDocontrоller откроется поверх ListController .
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
        // блок замыкания локальный. слабую или безхозную ссылку ставить не надо.
        let delete = UIContextualAction(style: .destructive, title: nil) {(_, _, _) in
            self.allTodos.remove(at: indexPath.row)
            ToDoSettings.shared.removeToDo(indexToDo: indexPath.row)
            self.fetchToDosFromUserDefault()
            self.didSetAllTodosArray()
            self.didToDoTableViewReloadData()
        }
        delete.backgroundColor = Colors.shared.viewBackround
        delete.image = UIImage(named: "trash")
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: Delegate
extension ListController: UpdateListDelegate {
    func fetchToDosFromUserDefault() {
        todosFromUserDefault = ToDoSettings.shared.fetchArray()
    }

    func didSetAllTodosArray() {
        allTodos = todosFromUserDefault + todosFromAPI
    }

    func didToDoTableViewReloadData() {
        listView.toDoTableView.reloadData()
    }

    func updateConstraints() {
        listView.addButtonBottomConstraint.constant  = -60
    }
}

// MARK: Animations
extension ListController {
    func changeTitleFromButtonsWithAnimation() {
        if todosFromUserDefault.count >= 1 && listView.toDoTableView.isEditing == false {
            listView.toDoTableView.setEditing(true, animated: true)
            UIView.transition(
                with: listView.addButton,
                duration: 1,
                options: .transitionCrossDissolve,
                //  выполнение анимации не приводит к блокированию self внутри замыкания, содержащего анимацию.
                animations: {
                    self.listView.addButton.setImage(UIImage(named: "Box"), for: .normal)
                    self.navigationItem.rightBarButtonItem?.title = "Готово"
                }
            )
        } else {
            UIView.transition(
                with: listView.addButton,
                duration: 0.4,
                options: .transitionFlipFromBottom,
                //  выполнение анимации не приводит к блокированию self внутри замыкания, содержащего анимацию.
                animations: {
                    self.listView.addButton.setImage(UIImage(named: "Plus"), for: .normal)
                    self.listView.toDoTableView.setEditing(false, animated: true)
                    self.navigationItem.rightBarButtonItem?.title = "Выбрать"
                }
            )
        }
    }

    func showAddButtonWithAnimation() {
        listView.addButton.layer.cornerRadius = listView.addButton.frame.width / 2
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            // выполнение анимации не приводит к блокированию self внутри замыкания, содержащего анимацию.
            animations: {
                self.listView.addButtonBottomConstraint.constant -= self.view.bounds.height
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.springAnimationWithAddButton()
            }
        )
    }

    func tapAddButtonWithAnimation() {
        // выполнение анимации не приводит к блокированию self внутри замыкания, содержащего анимацию.
        UIView.animate(withDuration: 1.5) {
            self.listView.addButtonBottomConstraint.constant -= self.listView.addButton.frame.height
            self.view.layoutIfNeeded()
        }

        UIView.animate(
            withDuration: 0.5,
            delay: 0.5,
            options: .curveEaseIn,
            // выполнение анимации не приводит к блокированию self внутри замыкания, содержащего анимацию.
            animations: {
                self.listView.addButtonBottomConstraint.constant += self.view.frame.height
                self.view.layoutIfNeeded()
                // выполнение анимации не приводит к блокированию self внутри замыкания, содержащего анимацию.
            }, completion: {_ in
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
            options: [.curveEaseOut],
            // выполнение анимации не приводит к блокированию self внутри замыкания, содержащего анимацию.
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
            // выполнение анимации не приводит к блокированию self внутри замыкания, содержащего анимацию.
            animations: {
                self.listView.addButton.frame.origin.y += 15
            }
        )
    }
}
