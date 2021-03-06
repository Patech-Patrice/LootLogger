//
//  Item.swift
//  LootLogger
//
//  Created by Patrice Drayton on 2/28/22.
//

import UIKit


//create a table view with rows.  Each row will display an item with info such as name, serial number, and value in dollars. Serial number is an optional string.
//Equatable:
//Codable: ensures that Item instances can be saved to and loaded from the disk. Codable types conform to the encodable and decodable protocols.  Any codable type whose properties are all Codable automatically conforms to the protocol itself.  Item satisfies this requirement, as types of its properties (String, Int, String?, and Date) all conform to Codable. Now that Item can be encoded and decoded a coder is needed.
class Item: Equatable, Codable {
    
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: Date
    //When an image is added to the store, it's put in the cache under a unique key, and the associated Item object will be given that key.  When the detailViewController wants an image from the store, it will ask its item for the key and search the cache for the image.  Add a new property to store the key.
    let itemKey: String
    
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name
        && lhs.serialNumber == rhs.serialNumber
        && lhs.valueInDollars == rhs.valueInDollars
        && lhs.dateCreated == rhs.dateCreated
    
    }
 
    
    //add a designated initializer: a primary initializer for the class which ensures that all properties in the class have a value. Once ensured, a designated initializer calls a designated initializer on its superclass(if it has one).  This initializer takes in arguments for name, serial number and value in dollars. Since the argument names and the property names are the same, use self to distinguish the property from the argument.
    init(name: String, serialNumber: String?, valueInDollars: Int) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = Date()
        //generate  UUID(unique identifier) and set it as the itemKey
        self.itemKey = UUID().uuidString
    }
    
    //Add a convenience initializer to Item that creates a randomly generated item.  Convenience initializers are considered helpers and are optional; always call another initializer on the SAME class.  If random is true, the instance instance is configured with a random name, serial number and value.
    convenience init( random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork","Mac",]
            
            let randomAdjective = adjectives.randomElement()!
            let randomNoun = nouns.randomElement()! //force unwrapping of random element
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int.random(in: 0..<100)
            let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
            self.init(name: randomName,
                      serialNumber: randomSerialNumber,
                      valueInDollars: randomValue)
        }else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
    }
    
    
}
