//
//  ItemStore.swift
//  LootLogger
//
//  Created by Patrice Drayton on 2/28/22.
//

import UIKit

//define the ItemStore class and declare a property to store the list of items.  The ItemsViewController will call a method on ItemStore when it wants a new Item to be created.The ItemStore will create the object and add it to an array of instances of Item.
//
class ItemStore {
    var allItems = [Item]()
    //ItemStore needs to construct a URL to the file.  When the ItemStore class is instantiated, the closure () will be run and the return value will be assigned to the itemArchiveUrl property.  The method urls(for:in) searches the file system for a URL that meets the criteria given by the arguments.  THe return value of urls(for:in) is an array of URLs.
    let itemArchiveURL: URL = {
        let documentsDirectories =
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.plist")
    }()
    //add a property of ItemStore
    var itemStore: ItemStore!
    
    //add an item creation method to create and return a new item.  @discarableResult means that a caller of this function is free to ignore the result of calling this function.
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    //implement the designated initializer to add five random items by populating the ItemStore with Item instances. This block not needed once a user can add and remove items from the store.
//    init() {
//        for _ in 0..<5 {
//            createItem()
//        }
//    }
    
    //Method to remove an item from the store
    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
    }
    
    //To move a or reorder a row or an array of items, implement the tableView(_moveRowAt:to:) method.  First, you need to give the ItemStore a method to change the order of items in its allItems array.
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        //Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        //Remove item from array
        allItems.remove(at: fromIndex)
        
        //Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
        
        
        
    }
    
    
    //Coder is responsible for encoding a type into some external presentation. The PropertyListEncoder saves data out in a property list format; and JSONEncoder saves data out in a JSON format.  Item will be serialized using a property list.
    //Property list is represented using an XML or binary format and can hold Array, Bool, Data, Date, Dictionary, FLoat, Int and String properties.
    
    //saves the item; uses a do-catch statement to catch the error
   @objc func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL)")
        do{
            //create an instance of PropertyListEncoder that calls the encode(_:) method on the encoder and passes in the allItems array which will encode each of the Item instances. The encode(_:) method returns an instance of Data.
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(allItems)
            //write out the data to the itemArchiveURL.  the .atomic option ensures that there is no data corruption. Item will not be persisted to disk when the saveChanges() method is called.
            try data.write(to: itemArchiveURL, options: [.atomic])
            print("saved all of the items")
            return true
        } catch  let encodingError {
            print("Error encoding allItems: \(encodingError)")
            return false
        }
        
    }
    
    //override init() to add an observer for the didEnterBackgroundNotification to save the encoded data for instances of Item when the app exits. NotificationCenter is written in ObjC so saveChanges needs to be exposed to ObjC by adding @objc.
    init() {
        //To load instances of Item when the application launces, use the PropertyListDecoder type when the ItemStore is created
        do{
            let data = try Data(contentsOf: itemArchiveURL)
            let unarchiver = PropertyListDecoder()
            let items = try unarchiver.decode([Item].self, from: data)
            allItems = items
        } catch {
            print("Error reading in saved items: \(error)")
        }
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(saveChanges),
                                       name: UIScene.didEnterBackgroundNotification,
                                       object: nil)
    }
    
   
   
    
    
    

}
