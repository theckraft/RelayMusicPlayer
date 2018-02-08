//
//  Song.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 11/9/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class Song: BaseEntity {
    
    var title: String
    
    //not sure how to handle this
    //we shouldn't take the time to populate this if we don't have to
    var artists: [Artist]
    var requests: [Request] = []
    var plays: [Play] = []
    
    init(title: String, artists: [Artist], requests: [Request], plays: [Play]) {
        self.title = title
        self.artists = artists
        self.requests = requests
        self.plays = plays
        super.init()
    }
    
    init(title: String, artists: [Artist]) {
        self.title = title
        self.artists = artists
        super.init()
    }
    
    private enum CodingKeys: String, CodingKey {
        case title
        case artists
        case requests
        case plays
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.artists = try container.decode([Artist].self, forKey: .artists)
        self.requests = try container.decode([Request].self, forKey: .requests)
        self.plays = try container.decode([Play].self, forKey: .plays)
        try super.init(from: decoder)
    }
}
