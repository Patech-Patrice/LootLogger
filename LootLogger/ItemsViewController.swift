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
        
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        
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
    
 
}
