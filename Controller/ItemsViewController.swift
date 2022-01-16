//
//  ItemsView.swift
//  TableViewProgrammatically
//
//  Created by Rauf Aliyev on 02.01.22.
//

import UIKit

class ItemsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var itemsId = "Cell"
    let cellSpacingHeight: CGFloat = 5
    var newItemText = UITextField()
    var priorityColor = Int()
    var categorySelected : Category?
    
    lazy var itemsViewModel: ItemsViewModel = {
        let model = ItemsViewModel()
        return model
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItemsTableView()
        setupNavigationBar()
        do {
            itemsViewModel.parentCategory = categorySelected!
        } catch {
            print("failed to assign selectedCategory \(error)")
        }
        itemsViewModel.listOfItems = itemsViewModel.loadData(categorySelected!)
        tableView.register(ItemsTableViewCell.self, forCellReuseIdentifier: itemsId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsViewModel.listOfItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemsId, for: indexPath) as! ItemsTableViewCell
        cell.textLabel?.text = itemsViewModel.listOfItems[indexPath.row].itemsName
        let colorIndex = itemsViewModel.listOfItems[indexPath.row].itemColor
        cell.cellImage.backgroundColor = itemsViewModel.definePriority(Int(colorIndex))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToDelete = itemsViewModel.listOfItems[indexPath.row]
            itemsViewModel.listOfItems.remove(at: indexPath.row)
            itemsViewModel.removeItem(data: itemToDelete)
            tableView.reloadData()
        }
    }
    
    func setupItemsTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupNavigationBar(){
        navigationItem.title = "Items"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItems))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addItems(){
        let addVC = AddViewController()
        present(UINavigationController(rootViewController: addVC), animated: true, completion: nil)
        addVC.delegate = self
    }
}

extension ItemsViewController : AddViewControllerDelegate {
    
    
    func addTextOfItem(_ textField: UITextField, _ priority: Int ) {
        itemsViewModel.addItems(text: textField, priority: priority, parentCategory: categorySelected!)
        tableView.reloadData()
    }
    
    func addTextPriority(_ priority: Int) {
        priorityColor = priority
    }
    
    
}
