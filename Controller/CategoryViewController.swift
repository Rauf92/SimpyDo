//
//  CategoryViewController2.swift
//  TableViewProgrammatically
//
//  Created by Rauf Aliyev on 03.01.22.
//

import UIKit
import CoreData


class CategoryViewController : UIViewController {
    
    var id = "Cell"
    let cellSpacingHeight: CGFloat = 5
    
    
    
    lazy var categoryViewModel: CategoryViewModel = {
        let model = CategoryViewModel()
        return model
    }()
    
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
        setupTableViewConstrain()
        categoryViewModel.listOfCategories = categoryViewModel.loadData()
        setupSearchBar()
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryViewModel.listOfCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        cell.textLabel?.text = categoryViewModel.listOfCategories[indexPath.row].categoryName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToDelete = categoryViewModel.listOfCategories[indexPath.row]
            categoryViewModel.listOfCategories.remove(at: indexPath.row)
            categoryViewModel.removeItem(data: itemToDelete)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return cellSpacingHeight
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navVC = ItemsViewController()
        navigationController?.pushViewController(navVC, animated: true)
        navVC.categorySelected = categoryViewModel.listOfCategories[indexPath.row]
    }
    
    func setupTableViewConstrain(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: id)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func setupSearchBar(){
        navigationItem.title = "Categories"
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCategory))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addCategory(){
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            self.categoryViewModel.setInputText(input: textField)
        }
        
        let action = UIAlertAction(title: "Save", style: .default) { UIAlertAction in
            self.categoryViewModel.addCategory()
            self.categoryViewModel.listOfCategories = self.categoryViewModel.loadData()
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true) {
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
        }
    }
    
    @objc func dismissOnTapOutside(){
        self.dismiss(animated: true, completion: nil)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count != 0 {
            categoryViewModel.listOfCategories = categoryViewModel.filterSearchBar(searchText)
            self.tableView.reloadData()
        } else{
            categoryViewModel.listOfCategories = self.categoryViewModel.loadData()
            self.tableView.reloadData()        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        categoryViewModel.listOfCategories = self.categoryViewModel.loadData()
        self.tableView.reloadData()
    }
    
    
}
