//
//  SpotifySavedAlbum.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/18/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifySavedAlbum: Codable {
    var addedAt: String
    var album: SpotifyAlbum
    
    enum CodingKeys: String, CodingKey {
        case addedAt = "added_at"
        case album
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.addedAt = try container.decode(String.self, forKey: .addedAt)
        self.album = try container.decode(SpotifyAlbum.self, forKey: .album)
    }
}
