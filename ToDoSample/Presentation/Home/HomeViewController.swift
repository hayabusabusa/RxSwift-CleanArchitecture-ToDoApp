//
//  HomeViewController.swift
//  ToDoSample
//
//  Created by Yamada Shunya on 2019/03/20.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

protocol HomeView: class {
    func setToDo(_ list: [ToDoViewModel])
}

class HomeViewController: UIViewController, Storyboardable {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: HomePresenter!
    private var todoList: [ToDoViewModel] = [ToDoViewModel]()
    
    func inject(presenter: HomePresenter) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI
        setupUI()
        setupNavigationBar()
        setupTableView()
        
        presenter.loadToDo()
    }
}

extension HomeViewController: HomeView {
    
    func setToDo(_ list: [ToDoViewModel]) {
        todoList = list
        tableView.reloadData()
    }
}

// UI
extension HomeViewController {
    
    private func setupUI() {
        let screen = UIScreen.main.bounds
        let button = AnimationButton(frame: CGRect(x: screen.width - 66.0, y: screen.height - 74.0, width: 50.0, height: 50.0))
        button.backgroundColor = UIColor(red: 0 / 255, green: 122 / 255, blue: 255 / 255, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        button.setTitle("+", for: .normal)
        button.layer.cornerRadius = 25.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 2.0
        button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        button.layer.shadowOpacity = 0.6
        button.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        navigationItem.title = "TODO"
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80.0
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
    }
}

// Button action
extension HomeViewController {
    
    @objc private func tapAddButton() {
        AlertManager.alertWithTextField(self,
                                        title: "TODO 作成",
                                        message: "タイトルを入力してください",
                                        okTitle: "OK",
                                        cancelTitle: "Cancel",
                                        placeholder: "タイトル") { text in
                                            self.presenter.saveToDo(title: text)
        }
    }
}

// TableView
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        
        cell.setupCell(todoList[indexPath.row])
        cell.checkMarkButton.stateChangedAcion = { state in
            if state == .checked {
                self.presenter.updateToDo(id: self.todoList[indexPath.row].id)
                self.todoList.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.reloadData()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
