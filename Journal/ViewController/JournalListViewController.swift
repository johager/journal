//
//  JournalListViewController.swift
//  Journal
//
//  Created by James Hager on 3/22/22.
//

import UIKit

class JournalListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var journalListTableView: UITableView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        journalListTableView.dataSource = self
        JournalController.shared.loadFromPersistentStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        journalListTableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func createJournalButtonTapped(_ sender: UIButton) {
        guard let journalTitle = journalTitleTextField?.text, !journalTitle.isEmpty else { return }
        JournalController.shared.createJournal(title: journalTitle)
        journalTitleTextField.text = ""
        journalListTableView.reloadData()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEntryList" {
            print("JournalListViewController - prepare(for:sender:)")
            guard
                let indexPath = journalListTableView?.indexPathForSelectedRow,
                let destination = segue.destination as? EntryListTableViewController
            else { return }
            destination.journal = JournalController.shared.journals[indexPath.row]
        }
    }
}

extension JournalListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        JournalController.shared.journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)

        let journal = JournalController.shared.journals[indexPath.row]

        cell.textLabel?.text = journal.title
        
        if journal.entries.count == 1 {
            cell.detailTextLabel?.text = "1 Entry"
        } else {
            cell.detailTextLabel?.text = "\(journal.entries.count) Entries"
        }
        
        return cell
    }
}
