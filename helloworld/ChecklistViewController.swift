//
//  ViewController.swift
//  helloworld
//
//  Created by 田中タカシ on 2018-01-09.
//  Copyright © 2018 iwag. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
   var items: [ChecklistItem]
    
    
    required init?(coder aDecoder: NSCoder) {
        items = [ChecklistItem]()
        
        var item = ChecklistItem()
        item.text = "Walk the dog"
        item.checked = false
        items.append(item)
        
        item = ChecklistItem()
        item.text = "Brush my teeth"
        item.checked = true
        items.append(item)

        item = ChecklistItem()
        item.text = "Learn iOS development"
        item.checked = true
        items.append(item)
        
        item = ChecklistItem()
        item.text = "Soccer practice"
        item.checked = false
        items.append(item)

        item = ChecklistItem()
        item.text = "Eat ice cream"
        item.checked = true
        items.append(item)

        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCellEditingStyle,
        forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    func configureText(for cell: UITableViewCell,
                       with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)

        configureText(for: cell, with: items[indexPath.row])
        
        return cell
    }

    func configureCheckmark(for cell: UITableViewCell,
                            with item: ChecklistItem) {
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            items[indexPath.row].checked = !items[indexPath.row].checked
            configureCheckmark(for: cell, with: items[indexPath.row])
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    @IBAction func addItem() {
        let newRowIndex = items.count
        let item = ChecklistItem()
        item.text = "I am a new row"
        item.checked = false
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
        let controller = segue.destination as! AddItemViewController
        controller.delegate = self
        }
    }
        
    func addItemViewControllerDidCancel(
        _ controller: AddItemViewController) {
        navigationController?.popViewController(animated:true)
    }
    
    func addItemViewController(
        _ controller: AddItemViewController,
        didFinishAdding item: ChecklistItem) {
        let newRowIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated:true)
    }
}

