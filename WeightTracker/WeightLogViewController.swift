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
        var appDel = (UIApplication.shared.delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.persistentContainer.viewContext
        var request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserWeights")
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
        var appDel = (UIApplication.shared.delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.persistentContainer.viewContext
        var request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserWeights")
        request.returnsObjectsAsFaults = false
        do {
            var results: Array = try context.fetch(request)
            var thisWeight = results[indexPath.row] as! UserWeights
            cell.textLabel?.text = thisWeight.weight! + "" + thisWeight.units!
            cell.detailTextLabel?.text = thisWeight.date!
        } catch {
            print(error)
        }
        
        return cell
    }
}
