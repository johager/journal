//
//  EntryController.swift
//  Journal
//
//  Created by James Hager on 3/21/22.
//

import Foundation

class EntryController {
    
    // MARK: - CRUD
    
    static func createEntry(withTitle title: String, andBody body: String, in journal: Journal) {
        let newEntry = Entry(title: title, body: body)
        JournalController.shared.add(entry: newEntry, to: journal)
    }
    
    static func update(entry: Entry, title: String, body:String) {
        entry.title = title
        entry.body = body
        JournalController.shared.saveToPersistentStore()
    }
    
    static func delete(_ entry: Entry, from journal: Journal) {
        JournalController.shared.remove(entry, from: journal)
    }
}
