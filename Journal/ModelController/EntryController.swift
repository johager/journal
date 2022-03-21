//
//  EntryController.swift
//  Journal
//
//  Created by James Hager on 3/21/22.
//

import Foundation

class EntryController {
    
    static let shared = EntryController()
    
    var entries = [Entry]()
    
    private var storeURL: URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let storeURL = urls[0].appendingPathComponent("Journal.json")
        return storeURL
    }
    
    // MARK: - CRUD
    
    func createEntryWith(title: String, body: String) {
        entries.append(Entry(title: title, body: body))
        saveToPersistentStore()
    }
    
    func delete(_ entry: Entry) {
        guard let index = entries.firstIndex(of: entry) else { return }
        entries.remove(at: index)
        saveToPersistentStore()
    }
    
    // MARK: - Persist
    
    func saveToPersistentStore() {
        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to: storeURL)
        } catch {
            print("saveToPersistentStore error: \(error)")
            print(error.localizedDescription)
        }
    }
    
    func loadFromPersistentStore() {
        do {
            let data = try Data(contentsOf: storeURL)
            entries = try JSONDecoder().decode([Entry].self, from: data)
        } catch {
            print("loadFromPersistentStore error: \(error)")
            print(error.localizedDescription)
        }
    }
}
