//
//  SpotifyExternalID.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 12/10/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyExternalID: Codable {
    // The identifier type, for example:
    // "isrc" - International Standard Recording Code
    // "ean" - International Article Number
    // "upc" - Universal Product Code
    var key: String
    // An external identifier for the object
    var value: String
    
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}
