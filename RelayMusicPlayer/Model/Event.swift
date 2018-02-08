//
//  Event.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 11/9/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class Event: BaseEntity {
    
    var title: String
    
    //must do something about the default empty arrays
    var users: [User] = []
    var dj: User
    var plays: [Play] = []
    var request: [Request] = []
    
    init(title: String, dj: User) {
        self.title = title;
        self.dj = dj;
        super.init()
    }
    
    private enum CodingKeys: String, CodingKey {
        case title
        case users
        case dj
        case plays
        case request
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.users = try container.decode([User].self, forKey: .users)
        self.dj = try container.decode(User.self, forKey: .dj)
        self.plays = try container.decode([Play].self, forKey: .plays)
        self.request = try container.decode([Request].self, forKey: .request)
        try super.init(from: decoder)
    }
    
}
