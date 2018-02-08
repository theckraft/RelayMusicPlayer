//
//  SpotifyArtist.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 12/9/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyArtist: Artist, SpotifyProtocol {
    
    //external url object - Known external URLs for this artist
    var externalURLs: SpotifyExternalURL
    //followers objects - Information about the followers of the artist
    var followers: SpotifyFollowers
    // A list of the genres the artist is associated with. For example: "Prog Rock", "Post-Grunge". (If not yet classified, the array is empty.)
    var genres: [String]
    // A link to the Web API endpoint providing full details of the artist
    var href: String
    // The Spotify ID for the artist
    var spotifyId: String
    // array of image objects - Images of the artist in various sizes, widest first
    var images: [SpotifyImage]
    //The popularity of the artist. The value will be between 0 and 100, with 100 being the most popular. The artist's popularity is calculated from the popularity of all the artist's tracks
    var popularity: Int
    // The object type: "artist"
    var type: String
    // The Spotify URI for the artist
    var uri: String
    
    init(name: String, externalURLs: SpotifyExternalURL, followers: SpotifyFollowers, genres: [String], href: String, spotifyId: String, images: [SpotifyImage], popularity: Int, type: String, uri: String) {
        self.externalURLs = externalURLs
        self.followers = followers
        self.genres = genres
        self.href = href
        self.spotifyId = spotifyId
        self.images = images
        self.popularity = popularity
        self.type = type
        self.uri = uri
        super.init(name: name)
    }
    
    enum CodingKeys: String, CodingKey {
        case externalURLs = "external_urls"
        case followers
        case genres
        case href
        case images
        case popularity
        case spotifyId = "id"
        case type
        case uri
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.externalURLs = try container.decode(SpotifyExternalURL.self, forKey: .externalURLs)
        self.followers = try container.decode(SpotifyFollowers.self, forKey: .followers)
        self.genres = try container.decode([String].self, forKey: .genres)
        self.href = try container.decode(String.self, forKey: .href)
        self.spotifyId = try container.decode(String.self, forKey: .spotifyId)
        self.images = try container.decode([SpotifyImage].self, forKey: .images)
        self.popularity = try container.decode(Int.self, forKey: .popularity)
        self.type = try container.decode(String.self, forKey: .type)
        self.uri = try container.decode(String.self, forKey: .uri)
        try super.init(from: decoder)
    }
}
