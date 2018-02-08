//
//  SpotifyRestriction.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 1/13/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyRestriction: Codable {
    var reason: String
    
    init(reason: String) {
        self.reason = reason
    }
}
