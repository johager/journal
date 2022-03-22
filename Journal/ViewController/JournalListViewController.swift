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
    @IBOutlet weak var createJournalButton: UIButton!
    @IBOutlet weak var journalListTableView: UITableView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        journalTitleTextField.addTarget(self, action: #selector(checkJournalTitleTextField), for: .editingChanged)
        createJournalButton.isEnabled = false
        journalListTableView.dataSource = self
        JournalController.shared.loadFromPersistentStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        journalListTableView.reloadData()
    }
    
    // MARK: - Actions
    
    @objc func checkJournalTitleTextField(sender: UITextField) {
        if let text = sender.text, !text.isEmpty {
            createJournalButton.isEnabled = true
        } else {
            createJournalButton.isEnabled = false
        }
    }
    
    @IBAction func createJournalButtonTapped(_ sender: UIButton) {
        guard let journalTitle = journalTitleTextField?.text, !journalTitle.isEmpty else { return }
        JournalController.shared.createJournal(title: journalTitle)
        journalTitleTextField.text = ""
        journalTitleTextField.resignFirstResponder()
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

// MARK: - UITableViewDataSource

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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let journal = JournalController.shared.journals[indexPath.row]
            JournalController.shared.delete(journal)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
