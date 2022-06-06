//
//  ListViewController.swift
//  Notes
//
//  Created by Антон Макаров on 04.06.2022.
//

import UIKit

protocol ListDisplayLogic: AnyObject {
    func displayData(viewModels: [ListCellViewModel])
    func dispalayError(error: String)
}

class ListViewController: UIViewController {
    var interactor: ListBusinessLogic?
    var router: ListRoutingLogic?
    private let networkServices: Networking = NetworkService()

    private var inetListModels: [ListCellViewModel] = []
    private var defaultListModels: [ListCellViewModel] = []
    private var allListModels: [ListCellViewModel] = []
    var selectRows = [IndexPath]()

    let toDoTableView = UITableView()
    let addButton = UIButton()
    let activityIndicator = UIActivityIndicatorView()

    var addButtonBottomConstraint: NSLayoutConstraint!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
        setupNavigationBar()
        interactor?.fetchToDo()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addButtonBottomConstraint.constant += view.bounds.height
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAddButtonWithAnimation()
    }

    // MARK: Set Views
    private func setViews() {
        title = "Заметки"
        view.backgroundColor = Colors.shared.viewBackround

        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        toDoTableView.allowsMultipleSelectionDuringEditing = true
        toDoTableView.register(ListCell.self, forCellReuseIdentifier: ListCell.reuseId)
        toDoTableView.separatorStyle = .none
        toDoTableView.showsVerticalScrollIndicator = false
        toDoTableView.backgroundColor = Colors.shared.viewBackround

        addButton.setImage(UIImage(named: "Plus"), for: .normal)
        addButton.clipsToBounds = true
        addButton.contentMode = .scaleAspectFit
        addButton.titleLabel?.font = .systemFont(ofSize: 25, weight: .semibold)

        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.style = .large
        activityIndicator.color = .darkGray
    }
    // MARK: Set Constraints
    private func setConstraints() {
        Helper.tamicOff(views: [toDoTableView, addButton, activityIndicator])
        Helper.add(subviews: [toDoTableView], superView: view)
        Helper.add(subviews: [addButton, activityIndicator], superView: toDoTableView)
        NSLayoutConstraint.activate([
            toDoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            toDoTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 14),
            toDoTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toDoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -9),

            addButton.rightAnchor.constraint(equalTo: toDoTableView.safeAreaLayoutGuide.rightAnchor, constant: -6),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.widthAnchor.constraint(equalToConstant: 50),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        addButtonBottomConstraint = NSLayoutConstraint(
            item: addButton,
            attribute: .bottom ,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1,
            constant: -60
        )
        view.addConstraint(addButtonBottomConstraint)
    }
// MARK: - Setup Navigation Bar
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
        if !toDoTableView.isEditing {
            toDoTableView.setEditing(true, animated: true)
        }
    }

//    private func addTargets() {
//        addButton.addTarget(self, action: #selector(addOrRemoveToDo), for: .touchUpInside)
//    }
    private func didSelectAndDeselectMultipleRows(tableView: UITableView, indexPath: IndexPath) {
        selectRows.removeAll()
        if let indexRow = tableView.indexPathsForSelectedRows {
            selectRows = indexRow
        }
    }

//    @objc
//    private func addOrRemoveToDo() {
//        if listView.toDoTableView.isEditing {
//            if selectRows.isEmpty {
//                alertShowError(message: "Вы не выбрали ни одной заметки .", title: "Внимание .")
//            }
//            selectRows.sort { $0.row > $1.row }
//            for indexPath in selectRows {
//                allTodos.remove(at: indexPath.row)
//                listView.toDoTableView.beginUpdates()
//                listView.toDoTableView.deleteRows(
//                    at: [IndexPath(row: indexPath.row, section: 0)],
//                    with: .top
//                )
//                listView.toDoTableView.endUpdates()
//                ToDoSettings.shared.removeToDo(indexToDo: indexPath.row)
//            }
//            listView.toDoTableView.setEditing(false, animated: true)
//            navigationItem.rightBarButtonItem?.title = "Выбрать"
//            listView.addButton.setImage(UIImage(named: "Plus"), for: .normal)
//            selectRows.removeAll()
//        } else {
//            tapAddButtonWithAnimation()
//        }
//    }

}

// MARK: - DisplayData
extension ListViewController: ListDisplayLogic {
    func displayData(viewModels: [ListCellViewModel]) {
        inetListModels = viewModels
        allListModels = defaultListModels + inetListModels
        toDoTableView.reloadData()
        activityIndicator.stopAnimating()
    }

    func dispalayError(error: String) {
        alertShowError(message: error, title: "Произошла ошибка !")
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allListModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListCell.reuseId,
            for: indexPath
        ) as? ListCell else {
            fatalError("Don't get cell")
        }
        let listViewModel = allListModels[indexPath.row]
        cell.setContentToListCell(from: listViewModel)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        94
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !tableView.isEditing {
            let cellViewModel = inetListModels[indexPath.row]
            router?.presentDetail(cell: cellViewModel, index: indexPath.row)
        } else {
            didSelectAndDeselectMultipleRows(tableView: tableView, indexPath: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        didSelectAndDeselectMultipleRows(tableView: tableView, indexPath: indexPath)
    }
}
// MARK: - Animations
extension ListViewController {
    func showAddButtonWithAnimation() {
        addButton.layer.cornerRadius = addButton.frame.width / 2
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            // выполнение анимации не приводит к блокированию self внутри замыкания, содержащего анимацию.
            animations: {
                self.addButtonBottomConstraint.constant -= self.view.bounds.height
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.springAnimationWithAddButton()
            }
        )
    }

    func springAnimationWithAddButton() {
        let frame = addButton.frame
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.1,
            initialSpringVelocity: 5,
            options: [.curveEaseOut],
            // выполнение анимации не приводит к блокированию self внутри замыкания, содержащего анимацию.
            animations: {
                self.addButton.frame = CGRect(
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
                self.addButton.frame.origin.y += 15
            }
        )
    }
}