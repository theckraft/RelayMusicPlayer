//
//  Request.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 11/9/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class Request: Action {
    
    var song: Song
    
    init(user: User, event: Event, song: Song) {
        self.song = song
        super.init(user: user, event: event)
    }
    
    private enum CodingKeys: String, CodingKey {
        case song
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.song = try container.decode(Song.self, forKey: .song)
        try super.init(from: decoder)
    }
}
