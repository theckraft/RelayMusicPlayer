//
//  SpotifyCursorPaging.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/8/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyCursorPaging<SpotifyObject>: Codable {
    // A link to the Web API endpoint returning the full result of the request
    var href: String
    // The requested data
    var items: [SpotifyObject]
    // The maximum number of items in the response (as set in the query or by default)
    var limit: Int
    // URL to the next page of items. (null if none)
    var next: String
    //The cursors used to find the next set of items.
    var cursors: SpotifyCursor
    // The total number of items available to return
    var total: Int
    
    init(href: String, items: [SpotifyObject], limit: Int, next: String, cursors: SpotifyCursor, total: Int) {
        self.href = href
        self.items = items
        self.limit = limit
        self.next = next
        self.cursors = cursors
        self.total = total
    }
    
    enum CodingKeys: String, CodingKey {
        case href
        case items
        case limit
        case next
        case cursors
        case total
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(href, forKey: .href)
        try container.encode(items, forKey: .items)
        try container.encode(limit, forKey: .limit)
        try container.encode(next, forKey: .next)
        try container.encode(cursors, forKey: .cursors)
        try container.encode(total, forKey: .total)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.href = try container.decode(String.self, forKey: .href)
        self.items = try container.decode([SpotifyObject].self, forKey: .items)
        self.limit = try container.decode(Int.self, forKey: .limit)
        self.next = try container.decode(String.self, forKey: .next)
        self.cursors = try container.decode(SpotifyCursor.self, forKey: .cursors)
        self.total = try container.decode(Int.self, forKey: .total)
    }
}
