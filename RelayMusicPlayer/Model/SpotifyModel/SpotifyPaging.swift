//
//  SpotifyPaging.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 12/10/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyPaging<SpotifyObject>: Codable {
    // A link to the Web API endpoint returning the full result of the request
    var href: String
    // The requested data
    var items: [SpotifyObject]
    // The maximum number of items in the response (as set in the query or by default)
    var limit: Int
    // URL to the next page of items. (null if none)
    var next: String
    // The offset of the items returned (as set in the query or by default)
    var offset: Int
    // URL to the previous page of items. (null if none)
    var previous: String
    // The total number of items available to return
    var total: Int
    
    init(href: String, items: [SpotifyObject], limit: Int, next: String, offset: Int, previous: String, total: Int) {
        self.href = href
        self.items = items
        self.limit = limit
        self.next = next
        self.offset = offset
        self.previous = previous
        self.total = total
    }
    
    enum CodingKeys: String, CodingKey {
        case href
        case items
        case limit
        case next
        case offset
        case previous
        case total
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(href, forKey: .href)
        try container.encode(items, forKey: .items)
        try container.encode(limit, forKey: .limit)
        try container.encode(next, forKey: .next)
        try container.encode(offset, forKey: .offset)
        try container.encode(previous, forKey: .previous)
        try container.encode(total, forKey: .total)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.href = try container.decode(String.self, forKey: .href)
        self.items = try container.decode([SpotifyObject].self, forKey: .items)
        self.limit = try container.decode(Int.self, forKey: .limit)
        self.next = try container.decode(String.self, forKey: .next)
        self.offset = try container.decode(Int.self, forKey: .offset)
        self.previous = try container.decode(String.self, forKey: .previous)
        self.total = try container.decode(Int.self, forKey: .total)
    }
}
