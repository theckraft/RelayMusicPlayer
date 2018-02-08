//
//  SpotifySearch.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/4/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

struct SpotifySearch: Decodable {
    let artists: SpotifyPaging<SpotifyArtist>?
    let albums: SpotifyPaging<SpotifyAlbum>?
    let playlists: SpotifyPaging<SpotifyPlaylist>?
    let tracks: SpotifyPaging<SpotifyTrack>?
    
    enum SpotifySearchKey: CodingKey {
        case artists
        case albums
        case playlists
        case tracks
    }

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SpotifySearchKey.self)
        self.artists = try container.decode(SpotifyPaging<SpotifyArtist>.self, forKey: .artists)
        self.albums = try container.decode(SpotifyPaging<SpotifyAlbum>.self, forKey: .albums)
        self.playlists = try container.decode(SpotifyPaging<SpotifyPlaylist>.self, forKey: .playlists)
        self.tracks = try container.decode(SpotifyPaging<SpotifyTrack>.self, forKey: .tracks)
    }
}
