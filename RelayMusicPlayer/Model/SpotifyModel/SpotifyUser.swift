//
//  SpotifyUser.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 1/13/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyUser: SpotifyProtocol, Codable {
    var birthdate: String
    var country: String
    var displayName: String
    var email: String
    var externalURLs: SpotifyExternalURL
    var followers: SpotifyFollowers
    var href: String
    var spotifyId: String
    var images: [SpotifyImage]
    var product: String
    var type: String
    var uri: String
    
    init(birthdate: String, country: String, displayName: String, email: String, externalURLs: SpotifyExternalURL, followers: SpotifyFollowers, href: String, spotifyId: String, images: [SpotifyImage], product: String, type: String, uri: String) {
        self.birthdate = birthdate
        self.country = country
        self.displayName = displayName
        self.email = email
        self.externalURLs = externalURLs
        self.followers = followers
        self.href = href
        self.spotifyId = spotifyId
        self.images = images
        self.product = product
        self.type = type
        self.uri = uri
    }
    
    enum CodingKeys: String, CodingKey {
        case birthdate
        case country
        case displayName = "display_name"
        case email
        case externalURLs = "external_urls"
        case followers
        case href
        case images
        case product
        case spotifyId = "id"
        case type
        case uri
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.birthdate = try container.decode(String.self, forKey: .birthdate)
        self.country = try container.decode(String.self, forKey: .country)
        self.displayName = try container.decode(String.self, forKey: .displayName)
        self.email = try container.decode(String.self, forKey: .email)
        self.externalURLs = try container.decode(SpotifyExternalURL.self, forKey: .externalURLs)
        self.followers = try container.decode(SpotifyFollowers.self, forKey: .followers)
        self.href = try container.decode(String.self, forKey: .href)
        self.images = try container.decode([SpotifyImage].self, forKey: .images)
        self.product = try container.decode(String.self, forKey: .product)
        self.spotifyId = try container.decode(String.self, forKey: .spotifyId)
        self.type = try container.decode(String.self, forKey: .type)
        self.uri = try container.decode(String.self, forKey: .uri)
    }
}
