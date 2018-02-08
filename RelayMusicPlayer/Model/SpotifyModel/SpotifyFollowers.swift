//
//  SpotifyFollowers.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 12/10/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyFollowers: Codable {
    // A link to the Web API endpoint providing full details of the followers; null if not available. Please note that this will always be set to null, as the Web API does not support it at the moment
    var href: String
    // The total number of followers
    var total: Int
    
    init(href: String, total: Int) {
        self.href = href
        self.total = total
    }
}
