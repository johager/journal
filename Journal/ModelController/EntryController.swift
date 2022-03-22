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
    
    static func update(entry: Entry, title: String, body:String, in journal: Journal) {
        let titleChanged = entry.title != title
        let bodyChanged = entry.body != body

        entry.title = title
        entry.body = body
        
        if titleChanged {
            JournalController.shared.sortJournal(journal)
        }
        
        if titleChanged || bodyChanged {
            JournalController.shared.saveToPersistentStore()
        }
    }
    
    static func delete(_ entry: Entry, from journal: Journal) {
        JournalController.shared.remove(entry, from: journal)
    }
}
