//
//  Artist.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 11/9/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class Artist: BaseEntity {
    
    var name: String
    
    //not sure how to handle this
    //we shouldn't take the time to populate this if we don't have to
    var songs: [Song] = []
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    private enum CodingKeys: String, CodingKey {
        case name, songs
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.songs = try container.decode([Song].self, forKey: .songs)
        try super.init(from: decoder)
    }
}
