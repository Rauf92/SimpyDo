//
//  ItemsViewModel.swift
//  SimplyDo
//
//  Created by Rauf Aliyev on 04.01.22.
//

import UIKit
import CoreData

class ItemsViewModel {
    
    

    let priority = ["Low", "Medium", "High"]
    var listOfItems : [Items] = []
    var inputText = UITextField()
    var itemCell = ItemsTableViewCell()
    var parentCategory = Category()
    
    lazy var viewModel: CategoryViewModel = {
        let model = CategoryViewModel()
        return model
    }()
    
    func addItems(text : UITextField, priority : Int,  parentCategory : Category) {
        let newItem = Items(context: viewModel.context)
        newItem.itemsName = text.text
        newItem.itemColor = Int16(priority)
        newItem.category = parentCategory
        definePriority(priority)
        self.listOfItems.append(newItem)
        self.saveData()
    }
    
    func saveData(){
        do{
            try viewModel.context.save()
        }catch{
            print("Failed to save data \(error)")
        }
    }
    
    func loadData(_ category: Category)->[Items]{
        let request : NSFetchRequest<Items> = Items.fetchRequest()
        let predicate = NSPredicate(format: "category.categoryName MATCHES %@", parentCategory.categoryName!)
        request.predicate = predicate
        do{
            listOfItems = try viewModel.context.fetch(request)
            
        }catch{
            print("error to fetch data \(error)")
        }
        return listOfItems
    }
    
    func getInputTextFromController(_ text : UITextField)-> UITextField{
        return text
    }
    
    func definePriority(_ priorityLevel : Int)-> UIColor{
        switch priorityLevel {
        case 0:
          return .blue
        case 1:
            return .green
        case 2:
            return  .red
        default:
            return  .white
        }
    }
    
    func removeItem(data: Items) {
        viewModel.context.delete(data)
        saveData()
    }
}
