//
//  SpotifyPlaylistsComposite.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/8/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

struct SpotifyPlaylistsComposite: Decodable {
    
    let message: String
    let playlists: SpotifyPaging<SpotifyPlaylist>
    
    enum PlaylistsKey: CodingKey {
        case message
        case playlists
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PlaylistsKey.self)
        self.message = try container.decode(String.self, forKey: .message)
        self.playlists = try container.decode(SpotifyPaging<SpotifyPlaylist>.self, forKey: .playlists)
    }
    
}
