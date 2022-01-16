//
//  AddViewController.swift
//  SimplyDo
//
//  Created by Rauf Aliyev on 04.01.22.
//

import UIKit

protocol AddViewControllerDelegate {
    func addTextOfItem(_ textField: UITextField, _ priority: Int)
}

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate : AddViewControllerDelegate?
    
    let itemsViewController = ItemsViewController()
    
    lazy var itemsViewModel: ItemsViewModel = {
        let model = ItemsViewModel()
        return model
    }()
    
    var selectedPicker = Int()
    
    var textLalel : UILabel = {
        let label = UILabel()
        label.text = "Select priority"
        label.textAlignment = .center
        return label
    }()
    
    let itemTextField: UITextField = {
       let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 20
        textField.placeholder = "Enter here"
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let picker: UIPickerView = {
       let picker = UIPickerView()
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupItemsTextField()
        setupNavigationBar()
        setupPicker()
        setupTextLabel()
    }
    
    func setupItemsTextField(){
        view.addSubview(itemTextField)
        
        NSLayoutConstraint.activate([
            itemTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            itemTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemTextField.heightAnchor.constraint(equalToConstant: 100),
            itemTextField.widthAnchor.constraint(equalToConstant: 370)
        ])
    }
    
    func setupNavigationBar(){
        navigationItem.title = "Add items"
        let addButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveItems))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        itemsViewModel.priority.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var attributedTitle : NSAttributedString!
        attributedTitle = NSAttributedString(string: itemsViewModel.priority[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return attributedTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPicker = row
    }
    
    func setupPicker(){
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)
        picker.delegate = self
        picker.dataSource = self
        
        NSLayoutConstraint.activate([
            picker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            picker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            picker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            picker.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func setupTextLabel(){
        textLalel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textLalel)
        
        NSLayoutConstraint.activate([
            textLalel.topAnchor.constraint(equalTo: picker.topAnchor, constant: -20),
            textLalel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textLalel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func saveItems(){
        self.delegate?.addTextOfItem(itemTextField, selectedPicker )
        itemsViewController.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}
