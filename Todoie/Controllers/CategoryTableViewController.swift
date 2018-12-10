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

    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    // MARK: - Tableview Delegate
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let  destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
        
    }

    // MARK: Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoie Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // What will happen when the user clicks add item
            if textField.text != "" {
                
                let newCategory = Category(context: self.context)
                newCategory.name = textField.text!
                
                self.categories.append(newCategory)
                
                self.saveCategories()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }

    // MARK: - Data Manipulation
    func saveCategories() {
        
        do {
            try context.save()
        } catch {
            print("Error in saving context \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    // LoadItems method has a internal (with) and External (request) params with default (Item.fetchRequest()) params
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categories = try context.fetch(request)
            
        } catch {
            print("Error fetching data from context \(error)")
        }
        
    }
    
}
