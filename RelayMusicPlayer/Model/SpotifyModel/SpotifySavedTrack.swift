//
//  SpotifySavedTrack.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/18/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifySavedTrack: Codable {
    var addedAt: String
    var track: SpotifyTrack
    
    enum CodingKeys: String, CodingKey {
        case addedAt = "added_at"
        case track
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.addedAt = try container.decode(String.self, forKey: .addedAt)
        self.track = try container.decode(SpotifyTrack.self, forKey: .track)
    }
}
