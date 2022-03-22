//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by James Hager on 3/21/22.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var journal: Journal?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journal?.entries.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        guard let journal = journal else { return cell }
        
        let entry = journal.entries[indexPath.row]
        cell.textLabel?.text = entry.title

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let journal = journal else { return }
            
            let entry = journal.entries[indexPath.row]
            JournalController.shared.remove(entry, from: journal)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDisplayEditEntry" {
            print("EntryListTableViewController - prepare(for:sender:)")
            guard
                let indexPath = tableView.indexPathForSelectedRow,
                let journal = journal,
                let destination = segue.destination as? EntryDetailViewController
            else { return }
            destination.journal = journal
            destination.entry = journal.entries[indexPath.row]
            
        } else if segue.identifier == "showAddEntry" {
            print("EntryListTableViewController - prepare(for:sender:)")
            guard
                let journal = journal,
                let destination = segue.destination as? EntryDetailViewController
            else { return }
            destination.journal = journal
        }
    }
}
