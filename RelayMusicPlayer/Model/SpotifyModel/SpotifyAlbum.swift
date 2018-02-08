//
//  SpotifyAlbum.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 12/10/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyAlbum: Album, SpotifyProtocol {
    // The type of the album: one of "album", "single", or "compilation"
    var albumType: String
    // array of simplified artist objects - The artists of the album. Each artist object includes a link in href to more detailed information about the artist
    var spotifyArtists: [SpotifyArtist] //artists
    // The markets in which the album is available: ISO 3166-1 alpha-2 country codes. Note that an album is considered available in a market when at least 1 of its tracks is available in that market
    var availableMarkets: [String]
    // array of copyright objects - The copyright statements of the album
    var copyrights: [SpotifyCopyright]
    // an external ID object - Known external IDs for the album
    var externalIDs: SpotifyExternalID
    // an external URL object - Known external URLs for this album
    var externalURLs: SpotifyExternalURL
    // A list of the genres used to classify the album. For example: "Prog Rock", "Post-Grunge". (If not yet classified, the array is empty.)
    var genres: [String]
    // A link to the Web API endpoint providing full details of the album
    var href: String
    // The Spotify ID for the album
    var spotifyId: String //id
    // array of image objects - The cover art for the album in various sizes, widest first
    var images: [SpotifyImage]
    // The label for the album
    var label: String
    // The popularity of the album. The value will be between 0 and 100, with 100 being the most popular. The popularity is calculated from the popularity of the album's individual tracks
    var popularity: Int
    // The date the album was first released, for example "1981-12-15". Depending on the precision, it might be shown as "1981" or "1981-12"
    var releaseDate: String
    // The precision with which release_date value is known: "year", "month", or "day"
    var releaseDatePrecision: String
    // array of simplified track objects inside a paging object - The tracks of the album
    var tracks: SpotifyPaging<SpotifyTrack>
    // The object type: "album"
    var type: String
    // The Spotify URI for the album
    var uri: String
    
    init(albumType: String, spotifyArtists: [SpotifyArtist], availableMarkets: [String], copyrights: [SpotifyCopyright], externalIDs: SpotifyExternalID, externalURLs: SpotifyExternalURL, genres: [String], href: String, spotifyId: String, images: [SpotifyImage], label: String, name: String, popularity: Int, releaseDate: String, releaseDatePrecision: String, tracks: SpotifyPaging<SpotifyTrack>, type: String, uri: String) {
        self.albumType = albumType
        self.spotifyArtists = spotifyArtists
        self.availableMarkets = availableMarkets
        self.copyrights = copyrights
        self.externalIDs = externalIDs
        self.externalURLs = externalURLs
        self.genres = genres
        self.href = href
        self.spotifyId = spotifyId
        self.images = images
        self.label = label
        self.popularity = popularity
        self.releaseDate = releaseDate
        self.releaseDatePrecision = releaseDatePrecision
        self.tracks = tracks
        self.type = type
        self.uri = uri
        super.init(name: name)
    }
    
    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case availableMarkets = "available_markets"
        case copyrights
        case externalIDs = "external_ids"
        case externalURLs = "external_urls"
        case genres
        case href
        case images
        case label
        case popularity
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case spotifyArtists = "artists"
        case spotifyId = "id"
        case tracks
        case type
        case uri
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.albumType = try container.decode(String.self, forKey: .albumType)
        //TODO - try setting artists too
        self.spotifyArtists = try container.decode([SpotifyArtist].self, forKey: .spotifyArtists)
        self.availableMarkets = try container.decode([String].self, forKey: .availableMarkets)
        self.copyrights = try container.decode([SpotifyCopyright].self, forKey: .copyrights)
        self.externalIDs = try container.decode(SpotifyExternalID.self, forKey: .externalIDs)
        self.externalURLs = try container.decode(SpotifyExternalURL.self, forKey: .externalURLs)
        self.genres = try container.decode([String].self, forKey: .genres)
        self.href = try container.decode(String.self, forKey: .href)
        self.spotifyId = try container.decode(String.self, forKey: .spotifyId)
        self.images = try container.decode([SpotifyImage].self, forKey: .images)
        self.label = try container.decode(String.self, forKey: .label)
        self.popularity = try container.decode(Int.self, forKey: .popularity)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.releaseDatePrecision = try container.decode(String.self, forKey: .releaseDatePrecision)
        self.tracks = try container.decode(SpotifyPaging<SpotifyTrack>.self, forKey: .tracks)
        self.type = try container.decode(String.self, forKey: .type)
        self.uri = try container.decode(String.self, forKey: .uri)
        try super.init(from: decoder)
    }
}
