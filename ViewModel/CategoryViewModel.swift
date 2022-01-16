//
//  CategoryViewModel.swift
//  TableViewProgrammatically
//
//  Created by Rauf Aliyev on 27.12.21.
//

import UIKit
import CoreData

protocol CategoryDelegate {
    func addItem()
    func fetchData()
}

class CategoryViewModel {
  
    
    var delegate: CategoryDelegate?
    var listOfCategories: [Category] = []
    var inputText: UITextField!
    
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //MARK: Setup of SearchBar

    
    //MARK: Functions to add new items
    func addCategory() {
        let newItem = Category(context: self.context)
        newItem.categoryName = self.inputText.text
        self.listOfCategories.append(newItem)
        self.saveData()
    }
    
    func setInputText(input: UITextField) {
        self.inputText = input
    }
    
    
    //MARK: Save Data to CoreData
    func saveData(){
        do{
            try context.save()
        }catch{
            print("Failed to save data \(error)")
        }
        self.delegate?.addItem()
    }
    
    func removeItem(data: Category) {
        context.delete(data)
        saveData()
    }
    
    func loadData()->[Category]{
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
            listOfCategories = try context.fetch(request)
            self.delegate?.fetchData()
        }catch{
            print("error to fetch data \(error)")
        }
        return listOfCategories
    }
    
    func filterSearchBar(_ enteredString: String)-> [Category]{
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        request.predicate = NSPredicate(format: "categoryName CONTAINS[cd] %@", enteredString)
        
        do{
            listOfCategories = try! context.fetch(request)
        }
        return listOfCategories
    }
}
