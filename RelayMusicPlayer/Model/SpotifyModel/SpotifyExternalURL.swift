//
//  SpotifyExternalURL.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 12/10/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyExternalURL: Codable {
    // The type of the URL, for example:
    // "spotify" - The Spotify URL for the object.
    var key: String
    // An external, public URL to the object
    var value: String
    
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }

}
