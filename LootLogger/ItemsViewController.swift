//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by Patrice Drayton on 2/28/22.`
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    //set height of the table view as soon as the app loads
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        //tells table view to compute the cell height based on the constraints
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
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
               //Create an instance of UITableViewCell with default appearance
        
        //update method to get or reuse cells; dequeue method will check the queue of cells to see whether a cell with the correct reuse identifier already exists. If so, it will dequeue that cell.  If there is no existing cell, a new cell will be created and returned.
        //Get a new or recycled cell.  Here we updated the reuse method to reflect the new subclass ItemCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell",
                                                 for: indexPath) as! ItemCell
        
        //Set the text on the cell with the description of the item that is at the nth index of items, where n=row this cell will appear in on the table view
        let item = itemStore.allItems[indexPath.row]
        
        //configure the cell with the item. For each label on the cell you set its text to some property from the appropriate Item.
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
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
    
    //Implement tableView(_:moveRowAt:to:) to update the store
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        //update the model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    //With the segue identified we can now pass the selected Item instance around by implementing prepare(for:sender:) function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //If the triggered segue is the "showItem" segue
        switch segue.identifier {
        case "showItem":
            //Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                
                //Get the item associated with this row and pass it along
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
            }
        default:
            //catch any unexpected segue identifiers and crash the app
            preconditionFailure("Unexpected segue identifier")
            }
        }
    
    //  //When ItemsViewController appears back on the screen,  the method viewWillAppear(_:) is called.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        }
    
    
    
    
    
    
    
    
}
    

