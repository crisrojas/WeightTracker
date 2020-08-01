//
//  WeightLogViewController.swift
//  WeightTracker
//
//  Created by Cristian Rojas on 10/06/2020.
//  Copyright © 2020 Cristian Rojas. All rights reserved.
//

import UIKit
import CoreData

class WeightLogViewController: UITableViewController {
    var totalEntries: Int = 0
    @IBOutlet var tbLog: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserWeights")
        request.returnsObjectsAsFaults = false
        do {
            totalEntries = try context.count(for: request)
        } catch {
            print(error)
        }
        print(totalEntries)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalEntries
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Default")
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserWeights")
        request.returnsObjectsAsFaults = false
        do {
            let results: Array = try context.fetch(request)
            let thisWeight = results[indexPath.row] as! UserWeights
            cell.textLabel?.text = thisWeight.weight! + "" + thisWeight.units!
            cell.detailTextLabel?.text = thisWeight.date!
        } catch {
            print(error)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDel = (UIApplication.shared.delegate as! AppDelegate)
            let context : NSManagedObjectContext = appDel.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserWeights")
            request.returnsObjectsAsFaults = false
            do {
                let results: Array = try context.fetch(request)
                let thisWeight = results[indexPath.row] as! UserWeights
                context.delete(thisWeight)
                try context.save()
                totalEntries  = totalEntries - 1
                tbLog.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func btnClearLog(_ sender: Any) {
        let appDel = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserWeights")
        request.returnsObjectsAsFaults = false
        do {
            let entries : Array = try context.fetch(request)
            
            for entry in entries {
                let entry = entry as! UserWeights
                context.delete(entry)
                
            }
           try context.save()
            totalEntries = 0
            tbLog.reloadData()
          
        } catch {
            print(error)
        }
    }
    
}
