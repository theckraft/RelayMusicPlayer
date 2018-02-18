//
//  SpotifyTracks.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/8/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

struct SpotifyTracks: Decodable {
    
    let tracks: [SpotifyTrack]
    
    enum TracksKey: CodingKey {
        case tracks
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TracksKey.self)
        self.tracks = try container.decode([SpotifyTrack].self, forKey: .tracks)
    }
}
