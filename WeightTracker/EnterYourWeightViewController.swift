//
//  EnterYourWeightViewController.swift
//  WeightTracker
//
//  Created by Cristian Rojas on 10/06/2020.
//  Copyright © 2020 Cristian Rojas. All rights reserved.
//


import UIKit
import CoreData

class EnterYourWeightViewController: UIViewController {

    @IBOutlet weak var units: UISwitch!
    @IBOutlet weak var txtWeight: UITextField!
    
    @IBAction func btnSavePressed(_ sender: Any) {
        var appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.persistentContainer.viewContext
        
        let ent = NSEntityDescription.entity(forEntityName: "UserWeights", in: context)!

        // Instance of our custom class, reference to entitiy
        var newWeight = UserWeights(entity: ent, insertInto: context)
        // Fill in the Core Data
        newWeight.weight = txtWeight.text
        if(units.isOn) {
            newWeight.units = "lbs"
        } else {
            //Switch is off
            newWeight.units = "kgs"
        }
        newWeight.date = "\(NSDate())"
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        txtWeight.text = ""
        print(newWeight)
        print(NSDate())
        
    }
    
    // Hide the keyboad
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        txtWeight.resignFirstResponder()
        return true
    }

    func touchesBegan(touches: NSSet!, withEvent event: UIEvent!)     {
        self.view.endEditing(true)
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
