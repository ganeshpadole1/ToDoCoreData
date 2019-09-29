//
//  ToDoTableViewController.swift
//  ToDoCoreData
//
//  Created by ganesh padole on 07/07/1941 Saka.
//  Copyright © 1941 ganesh padole. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {

    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Welcome")
    }

    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Add New Todey Item", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        
        let alertAction = UIAlertAction(title: "Add Item", style: .default) { [unowned alertController] _ in
            let answer = alertController.textFields![0]
            print(answer.text!)
            
            let item = Item(context: self.context)
            item.title = answer.text!
            item.done = false
            self.itemArray.append(item)
            self.saveItems()
        }
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true)
    }
   
    func saveItems() { // Add item into permanent store
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        tableView.reloadData()
    }
}

extension ToDoTableViewController {
    // MARK: - Table view data source
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(itemArray.count)
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        return cell
     }
}
