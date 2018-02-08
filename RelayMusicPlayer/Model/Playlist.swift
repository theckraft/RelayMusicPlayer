//
//  Playlist.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 11/12/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class Playlist: BaseEntity {
    
    var name: String
    
    var songs: [Song] = []
    
    //TODO -
    //User hasMany Playlist as followed_playlists (I think this would be hasAndBelongsToMany
    //User hasMany Playlist as created_playlists
    //Playlist hasMany as followers (hasAndBelongsToMany - users follow many playlists and playlist belongs to many users)
    //Playlist belongsToUser as creator
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case songs
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.songs = try container.decode([Song].self, forKey: .songs)
        try super.init(from: decoder)
    }
    
}
