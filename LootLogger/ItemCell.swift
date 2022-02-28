//
//  ItemCell.swift
//  LootLogger
//
//  Created by Patrice Drayton on 2/28/22.
//

import UIKit

//define item cell as a subclass of UITableViewCell. Layout the content for the item cell inside the prototype cells  section
class ItemCell: UITableViewCell {
    //create and connect outlets for each subview.  Each outlet is connected to each view in the item cell. Since they are outlets on a view and not a controller, connection must be made on the UI but not by control-click drag
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
}
