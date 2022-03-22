//
//  Journal.swift
//  Journal
//
//  Created by James Hager on 3/22/22.
//

import Foundation

class Journal: Codable {
    
    let title: String
    var entries: [Entry]
    
    init(title: String, entries: [Entry] = []) {
        self.title = title
        self.entries = entries
    }
}
