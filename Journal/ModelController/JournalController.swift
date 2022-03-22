//
//  JournalController.swift
//  Journal
//
//  Created by James Hager on 3/22/22.
//

import Foundation

class JournalController {
    
    static let shared = JournalController()
    
    var journals = [Journal]()
    
    private var persistentStoreURL: URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let storeURL = urls[0].appendingPathComponent("Journal.json")
        return storeURL
    }
    
    // MARK: - CRUD
    
    func createJournal(title: String) {
        journals.append(Journal(title: title))
        journals.sort(by: {$0.title < $1.title})
        saveToPersistentStore()
    }
    
    func delete(_ journal: Journal) {
        guard let index = journals.firstIndex(of: journal) else { return }
        journals.remove(at: index)
        saveToPersistentStore()
    }
    
    func add(entry: Entry, to journal: Journal) {
        guard let journalIndex = journals.firstIndex(of: journal) else { return }
        journals[journalIndex].entries.append(entry)
        sortJournal(journals[journalIndex])
        saveToPersistentStore()
    }
    
    func remove(_ entry: Entry, from journal: Journal) {
        guard let journalIndex = journals.firstIndex(of: journal) else { return }
        
        var entries = journals[journalIndex].entries
        
        guard let entryIndex = entries.firstIndex(of: entry) else { return }
        
        entries.remove(at: entryIndex)
        saveToPersistentStore()
    }
    
    // MARK: - Misc Methods
    
    func sortJournal(_ journal: Journal) {
        journal.entries.sort(by: {$0.title < $1.title})
    }
    
    // MARK: - Persist
    
    func saveToPersistentStore() {
        do {
            let data = try JSONEncoder().encode(journals)
            try data.write(to: persistentStoreURL)
        } catch {
            print("saveToPersistentStore error: \(error)")
            print(error.localizedDescription)
        }
    }
    
    func loadFromPersistentStore() {
        do {
            let data = try Data(contentsOf: persistentStoreURL)
            journals = try JSONDecoder().decode([Journal].self, from: data)
        } catch {
            print("loadFromPersistentStore error: \(error)")
            print(error.localizedDescription)
        }
    }
}