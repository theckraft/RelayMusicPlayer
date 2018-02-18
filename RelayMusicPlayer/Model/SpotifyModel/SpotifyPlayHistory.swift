//
//  SpotifyPlayHistory.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/18/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyPlayHistory: Codable {
    var track: SpotifyTrack
    var playedAt: String
    var context: SpotifyContext
    
    enum CodingKeys: String, CodingKey {
        case track
        case playedAt = "played_at"
        case context
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.track = try container.decode(SpotifyTrack.self, forKey: .track)
        self.playedAt = try container.decode(String.self, forKey: .playedAt)
        self.context = try container.decode(SpotifyContext.self, forKey: .context)
    }
}

