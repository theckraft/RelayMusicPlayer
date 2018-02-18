//
//  SpotifyContext.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/18/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyContext: Codable {
    var type: String
    var href: String
    var externalURLs: SpotifyExternalURL
    var uri: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case href
        case externalURLS = "external_urls"
        case uri
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(href, forKey: .href)
        try container.encode(externalURLs, forKey: .externalURLS)
        try container.encode(uri, forKey: .uri)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.href = try container.decode(String.self, forKey: .href)
        self.externalURLs = try container.decode(SpotifyExternalURL.self, forKey: .externalURLS)
        self.uri = try container.decode(String.self, forKey: .uri)
    }
}
