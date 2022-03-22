//
//  Entry.swift
//  Journal
//
//  Created by James Hager on 3/21/22.
//

import Foundation

class Entry: Codable {
    
    var title: String
    var body: String
    var timestamp: Date
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
        self.timestamp = Date()
    }
}
