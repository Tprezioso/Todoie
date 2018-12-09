//
//  CategoryTableViewController.swift
//  Todoie
//
//  Created by Thomas Prezioso on 12/9/18.
//  Copyright © 2018 Thomas Prezioso. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    
    // MARK: - Tableview Delegate
    
    // MARK: - Data Manipulation
    func saveCategory() {
        
        do {
            try context.save()
        } catch {
            print("Error in saving context \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    // LoadItems method has a internal (with) and External (request) params with default (Item.fetchRequest()) params
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        
        do {
            categoryArray = try context.fetch(request)
            
        } catch {
            print("Error fetching data from context \(error)")
        }
        
    }

    // MARK: Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoie Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // What will happen when the user clicks add item
            if textField.text != "" {
                
                let newCategory = Category(context: self.context)
                newCategory.name = textField.text!
                
                self.categoryArray.append(newCategory)
                
                self.saveCategory()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    
}
