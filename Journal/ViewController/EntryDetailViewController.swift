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
    
    var entry: Entry!
    
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
            let titleText = titleTextField.text,
            let bodyText = bodyTextView.text,
            !titleText.isEmpty,
            !bodyText.isEmpty
        else { return}
        
        if entry == nil {
            EntryController.shared.createEntryWith(title: titleText, body: bodyText)
        } else {
            // TODO: Add Update method
            print("An update method will be created tomorrow")
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
