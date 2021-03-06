//
//  CategoryTableViewController.swift
//  Todoie
//
//  Created by Thomas Prezioso on 12/9/18.
//  Copyright © 2018 Thomas Prezioso. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryTableViewController: SwipeTableViewController {

    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get cell from super class swipetableVC
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].color ?? "1D9BF6")
        cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
        
        return cell
    }
    
    // MARK: - Tableview Delegate
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let  destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }

    // MARK: - Action methods
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoie Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // What will happen when the user clicks add item
            if textField.text != "" {
                let newCategory = Category()
                newCategory.name = textField.text!
                newCategory.color = UIColor.randomFlat.hexValue()
                self.saveCategories(category: newCategory)
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            alert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }

    // Used for dismissing alert view when tap outside alert popup
    @objc func dismissAlertController(){
        self.dismiss(animated: true, completion: nil)
    }


    // MARK: - Data Manipulation
    func saveCategories(category: Category) {
        do {
            try realm.write {
                    realm.add(category)
            }
        } catch {
            print("Error in saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    // LoadItems method has a internal (with) and External (request) params with default (Item.fetchRequest()) params
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    // MARK: - Delete Data from Swipe
    // Override this function from the superclass to have swipe to delete
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print(error)
            }
        }
    }
    
}

