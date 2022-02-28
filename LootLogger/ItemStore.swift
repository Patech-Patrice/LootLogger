//
//  ItemStore.swift
//  LootLogger
//
//  Created by Patrice Drayton on 2/28/22.
//

import UIKit

//define the ItemStore class and declare a property to store the list of items.  The ItemsViewController will call a method on ItemStore when it wants a new Item to be created.The ItemStore will create the object and add it to an array of instances of Item.
class ItemStore {
    var allItems = [Item]()
    //add a property of ItemStore
    var itemStore: ItemStore!
    
    //add an item creation method to create and return a new item.  @discarableResult means that a caller of this function is free to ignore the result of calling this function.
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    //implement the designated initializer to add five random items by populating the ItemStore with Item instances
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }

}
