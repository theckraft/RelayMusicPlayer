//
//  SpotifyPlaylist.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 1/13/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyPlaylist: Playlist, SpotifyProtocol {
    var collaborative: Bool
    var description: String
    var externalURLs: SpotifyExternalURL
    var followers: SpotifyFollowers
    var href: String
    var spotifyId: Int //id
    var images: [SpotifyImage]
    //TODO - consider owner property in superclass Playlist instead of creator
    var owner: SpotifyUser
    //TODO - add this to superclass Playlist
    var isPublic: Bool //public
    var snapshotId: String
    var tracks: SpotifyPaging<SpotifyPlaylistTrack>
    var type: String
    var uri: String
    
    init(name: String, collaborative: Bool, description: String, externalURLs: SpotifyExternalURL, followers: SpotifyFollowers, href: String, spotifyId: Int, images: [SpotifyImage], owner: SpotifyUser, isPublic: Bool, snapshotId: String, tracks: SpotifyPaging<SpotifyPlaylistTrack>, type: String, uri: String) {
        self.collaborative = collaborative
        self.description = description
        self.externalURLs = externalURLs
        self.followers = followers
        self.href = href
        self.spotifyId = spotifyId
        self.images = images
        self.owner = owner
        self.isPublic = isPublic
        self.snapshotId = snapshotId
        self.tracks = tracks
        self.type = type
        self.uri = uri
        super.init(name: name)
    }
    
    enum CodingKeys: String, CodingKey {
        case collaborative
        case description
        case externalURLs = "external_urls"
        case followers
        case href
        case images
        case owner
        case isPublic = "public"
        case snapshotId = "snapshot_id"
        case spotifyId = "id"
        case tracks
        case type
        case uri
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.collaborative = try container.decode(Bool.self, forKey: .collaborative)
        self.description = try container.decode(String.self, forKey: .description)
        self.externalURLs = try container.decode(SpotifyExternalURL.self, forKey: .externalURLs)
        self.followers = try container.decode(SpotifyFollowers.self, forKey: .followers)
        self.href = try container.decode(String.self, forKey: .href)
        self.images = try container.decode([SpotifyImage].self, forKey: .images)
        self.owner = try container.decode(SpotifyUser.self, forKey: .owner)
        self.isPublic = try container.decode(Bool.self, forKey: .isPublic)
        self.snapshotId = try container.decode(String.self, forKey: .snapshotId)
        self.spotifyId = try container.decode(Int.self, forKey: .spotifyId)
        self.tracks = try container.decode(SpotifyPaging<SpotifyPlaylistTrack>.self, forKey: .tracks)
        self.type = try container.decode(String.self, forKey: .type)
        self.uri = try container.decode(String.self, forKey: .uri)
        try super.init(from: decoder)
    }
}
