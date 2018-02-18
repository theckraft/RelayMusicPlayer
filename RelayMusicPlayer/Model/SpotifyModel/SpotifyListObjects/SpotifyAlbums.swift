//
//  SpotifyAlbums.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/7/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

struct SpotifyAlbums: Decodable {
    let albums: [SpotifyAlbum]
    
    enum AlbumsKey: CodingKey {
        case albums
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumsKey.self)
        self.albums = try container.decode([SpotifyAlbum].self, forKey: .albums)
    }
}
