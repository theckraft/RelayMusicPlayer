//
//  SpotifyPlaylistTrack.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 1/13/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyPlaylistTrack: Codable {
    var addedAt: Date
    var addedBy: SpotifyUser
    var isLocal: Bool
    var track: SpotifyTrack
    
    init(addedAt: Date, addedBy: SpotifyUser, isLocal: Bool, track: SpotifyTrack) {
        self.addedAt = addedAt
        self.addedBy = addedBy
        self.isLocal = isLocal
        self.track = track
    }
    
    enum CodingKeys: String, CodingKey {
        case addedAt = "added_at"
        case addedBy = "added_by"
        case isLocal = "is_local"
        case track
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.addedAt = try container.decode(Date.self, forKey: .addedAt)
        self.addedBy = try container.decode(SpotifyUser.self, forKey: .addedBy)
        self.isLocal = try container.decode(Bool.self, forKey: .isLocal)
        self.track = try container.decode(SpotifyTrack.self, forKey: .track)
    }
    
}
