//
//  SpotifyArtists.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/8/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

struct SpotifyArtists: Decodable {
    
    let artists: [SpotifyArtist]
    
    enum ArtistsKey: CodingKey {
        case artists
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ArtistsKey.self)
        self.artists = try container.decode([SpotifyArtist].self, forKey: .artists)
    }
    
}
