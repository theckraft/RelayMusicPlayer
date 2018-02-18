//
//  SpotifyAlbumsComposite.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/8/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

struct SpotifyAlbumsComposite: Decodable {
    
    let message: String
    let albums: SpotifyPaging<SpotifyAlbum>
    
    enum AlbumsKey: CodingKey {
        case message
        case albums
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumsKey.self)
        self.message = try container.decode(String.self, forKey: .message)
        self.albums = try container.decode(SpotifyPaging<SpotifyAlbum>.self, forKey: .albums)
    }
    
}
