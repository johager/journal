//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by James Hager on 3/21/22.
//

import UIKit

class EntryDetailViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - Properties
    
    var journal: Journal?
    var entry: Entry?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - View methods
    
    func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard
            let journal = journal,
            let titleText = titleTextField.text,
            let bodyText = bodyTextView.text,
            !titleText.isEmpty,
            !bodyText.isEmpty
        else { return}
        
        if entry == nil {
            EntryController.createEntry(withTitle: titleText, andBody: bodyText, in: journal)
        } else {
            EntryController.update(entry: entry!, title: titleText, body: bodyText, in: journal)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
}
