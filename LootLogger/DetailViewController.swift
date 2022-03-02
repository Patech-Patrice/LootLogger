//
//  DetailViewController.swift
//  LootLogger
//
//  Created by Patrice Drayton on 3/1/22.
//



//to display the information on the selected item create a new subclass for that item
import UIKit

//have the DetailViewController conform to the UITextFieldDelegate

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    //outlet needed in order to access the subview
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    

    
    //add a property for an Item instance and override viewWillAppear(_:) to set up the interface
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    //add a property observer to the item property that updates the title of the navigationItem
    
    
    //number formatter
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    //date formatter
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
    }
    
    
    //View controller to be popped off or removed from the stack.  This function allows the values of the Item to be updated when the user taps the Back button on the nav bar.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //"Save" changes to item
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text,
           let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
            
        } else {
            item.valueInDollars = 0
        }
    }
    
    //implement textFieldShouldReturn method to call responder on the text field that is passed in
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func choosePhotoSource(_ sender: UIBarButtonItem) {
        print("Camera button pressed")
        //create an alert controller
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        //tell alert controller to use the popover presentation style which presents the view in a popover view on Ipad. 
        alertController.modalPresentationStyle = .popover
        //specify the bar button item that the popover should point at
        alertController.popoverPresentationController?.barButtonItem = sender
        
        //Add actions to the alert controller's action sheet
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            print("Present camera")
        }
        alertController.addAction(cameraAction)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            print("Present photo library")
        }
        alertController.addAction(photoLibraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        //With the action sheet configuredpresent the view controller modally to the user by calling present(_:animated:completion:) on the initiating view controller, passing in the view controller to present as the first argument
        present(alertController, animated: true, completion: nil)
    }

    
  
    
    
}
