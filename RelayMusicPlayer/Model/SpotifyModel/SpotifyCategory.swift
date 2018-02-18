//
//  SpotifyCategory.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/8/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyCategory: Codable {
    var href: String
    var icons: [SpotifyImage]
    var id: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case href
        case icons
        case id
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.href = try container.decode(String.self, forKey: .href)
        self.icons = try container.decode([SpotifyImage].self, forKey: .icons)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
