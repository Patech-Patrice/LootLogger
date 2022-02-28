//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by Patrice Drayton on 2/28/22.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    //create a table view header that will have two subviews that are instances of UIButton:, one to toggle editing mode and the other to add a new Item to the table.
    @IBAction func addNewItem(_ sender: UIButton) {
       //Create a new item and add it to the store
        let newItem = itemStore.createItem()
        //Figure out where that item is in the array
        if let index = itemStore.allItems.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            
            //Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
           
        
     
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        //If you are currently in editing mode...
        if isEditing {
            //Change text of button to inform user of state
            sender.setTitle("Edit", for: .normal)
            
            //turn off editing mode
            setEditing(false, animated: true)
        } else {
            //Change text of button to inform user of state
            sender.setTitle("Done", for: .normal)
            
            //Enter editing mode
            setEditing(true, animated: true)
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        //Create an instance of UITableViewCell with default appearance
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        //update method to get or reuse cells; dequeue method will check the queue of cells to see whether a cell with the correct reuse identifier already exists. If so, it will dequeue that cell.  If there is no existing cell, a new cell will be created and returned.
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                                 for: indexPath)
        
        //Set the text on the cell with the description of the item that is at the nth index of items, where n=row this cell will appear in on the table view
        let item = itemStore.allItems[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    //implement tableView(_:commit:forRowAt); when called on the data source it passes two arguments, first is editing for deletion sewcond confirms the deletion by calling the deletRows method
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        //If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            //Remove the item from the store
            itemStore.removeItem(item)
            
            //Also remove that row from the table view with an animation
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
    }
}
