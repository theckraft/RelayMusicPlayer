//
//  SpotifyTrackLink.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 1/13/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyTrackLink: Codable, SpotifyProtocol {
    var externalURLs: SpotifyExternalURL
    var href: String
    var spotifyId: String
    var type: String
    var uri: String
    
    init(externalURLs: SpotifyExternalURL, href: String, spotifyId: String, type: String, uri: String) {
        self.externalURLs = externalURLs
        self.href = href
        self.spotifyId = spotifyId
        self.type = type
        self.uri = uri
    }
    
    enum CodingKeys: String, CodingKey {
        case externalURLs = "external_urls"
        case href
        case spotifyId = "id"
        case type
        case uri
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.externalURLs = try container.decode(SpotifyExternalURL.self, forKey: .externalURLs)
        self.href = try container.decode(String.self, forKey: .href)
        self.spotifyId = try container.decode(String.self, forKey: .spotifyId)
        self.type = try container.decode(String.self, forKey: .type)
        self.uri = try container.decode(String.self, forKey: .uri)
    }
    
}
