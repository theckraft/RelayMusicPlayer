//
//  Action.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 11/9/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class Action: BaseEntity {
    
    var date: Date //when the event created
    
    var user: User
    var event: Event
    
    init(user: User, event: Event) {
        self.user = user
        self.event = event
        self.date = Date()
        super.init()
    }
    
    private enum CodingKeys: String, CodingKey {
        case date, user, event
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(Date.self, forKey: .date)
        self.user = try container.decode(User.self, forKey: .user)
        self.event = try container.decode(Event.self, forKey: .event)
        try super.init(from: decoder)
    }
}
