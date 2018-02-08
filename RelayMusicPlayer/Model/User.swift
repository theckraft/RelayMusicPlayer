//
//  User.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 11/9/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class User: BaseEntity {
    
    var username: String
    
    var actions: [Action] = []
    var events: [Event] = []
    
    var followedPlaylists: [Playlist] = []
    var createdPlaylists: [Playlist] = []
    
    var spotifyUser: SpotifyUser?
    
    init(username: String) {
        self.username = username
        super.init()
    }
    
    init(username: String, actions: [Action], events: [Event]) {
        self.username = username
        self.actions = actions
        self.events = events
        super.init()
    }
    
    private enum CodingKeys: String, CodingKey {
        case username
        case actions
        case events
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try container.decode(String.self, forKey: .username)
        self.actions = try container.decode([Action].self, forKey: .actions)
        self.events = try container.decode([Event].self, forKey: .events)
        try super.init(from: decoder)
    }
}
