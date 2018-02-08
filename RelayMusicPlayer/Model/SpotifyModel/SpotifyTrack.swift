//
//  SpotifyTrack.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 12/9/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyTrack: Song, SpotifyProtocol {
    //a simplified album object - The album on which the track appears.
    //The album object includes a link in href to full information about the album
    var album: SpotifyAlbum
    // The artists who performed the track. Each artist object includes a link in href to more detailed information about the artist
    var spotifyArtists: [SpotifyArtist]
    // A list of the countries in which the track can be played, identified by their ISO 3166-1 alpha-2 code
    var availableMarkets: [String]
    // The disc number (usually 1 unless the album consists of more than one disc)
    var discNumber: Int
    // The track length in milliseconds
    var durationMS: Int
    // Whether or not the track has explicit lyrics (true = yes it does; false = no it does not OR unknown) - MAYBE ADD THIS PROPERTY TO 'Song' MODEL
    var explicit: Bool
    // an external ID object - Known external IDs for the track
    var externalIDs: SpotifyExternalID
    // an external URL object - Known external URLs for this track
    var externalURLs: SpotifyExternalURL
    // A link to the Web API endpoint providing full details of the track
    var href : String
    // The Spotify ID for the track
    var spotifyId: String
    // Part of the response when Track Relinking is applied. If true, the track is playable in the given market. Otherwise false
    var isPlayable: Bool
    // a linked track object - Part of the response when Track Relinking is applied, and the requested track has been replaced with different track. The track in the linked_from object contains information about the originally requested track
    var linkedFrom: SpotifyTrackLink
    // a restrictions object - Part of the response when Track Relinking is applied, the original track is not available in the given market, and Spotify did not have any tracks to relink it with. The track response will still contain metadata for the original track, and a restrictions object containing the reason why the track is not available: "restrictions" : {"reason" : "market"}
    var restrictions: SpotifyRestriction
    // The popularity of the track. The value will be between 0 and 100, with 100 being the most popular.
    // The popularity of a track is a value between 0 and 100, with 100 being the most popular. The popularity is calculated by algorithm and is based, in the most part, on the total number of plays the track has had and how recent those plays are.
    // Generally speaking, songs that are being played a lot now will have a higher popularity than songs that were played a lot in the past. Duplicate tracks (e.g. the same track from a single and an album) are rated independently. Artist and album popularity is derived mathematically from track popularity. Note that the popularity value may lag actual popularity by a few days: the value is not updated in real time.
    var popularity: Int
    // A link to a 30 second preview (MP3 format) of the track. null if not available
    var previewURL: String
    // The number of the track. If an album has several discs, the track number is the number on the specified disc
    var trackNumber: Int
    // The object type: "track"
    var type: String
    // The Spotify URI for the track
    var uri: String
    
    init(title: String, album: SpotifyAlbum, availableMarkets: [String], spotifyArtists: [SpotifyArtist], discNumber: Int, durationMS: Int, explicit: Bool, externalIDs: SpotifyExternalID, externalURLs: SpotifyExternalURL, href: String, spotifyId: String, isPlayable: Bool, linkedFrom: SpotifyTrackLink, restrictions: SpotifyRestriction, popularity: Int, previewURL: String, trackNumber: Int, type: String, uri: String) {
        self.album = album
        self.spotifyArtists = spotifyArtists
        self.availableMarkets = availableMarkets
        self.discNumber = discNumber
        self.durationMS = durationMS
        self.explicit = explicit
        self.externalIDs = externalIDs
        self.externalURLs = externalURLs
        self.href = href
        self.spotifyId = spotifyId
        self.isPlayable = isPlayable
        self.linkedFrom = linkedFrom
        self.restrictions = restrictions
        self.popularity = popularity
        self.previewURL = previewURL
        self.trackNumber = trackNumber
        self.type = type
        self.uri = uri
        super.init(title: title, artists: spotifyArtists)
    }
    
    enum CodingKeys: String, CodingKey {
        case album
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalIDs = "external_ids"
        case externalURLs = "external_urls"
        case href
        case isPlayable = "is_playable"
        case linkedFrom = "linked_from"
        case popularity
        case previewURL = "preview_url"
        case restrictions
        case spotifyArtists = "artists"
        case spotifyId = "id"
        case trackNumber = "track_number"
        case type
        case uri
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.album = try container.decode(SpotifyAlbum.self, forKey: .album)
        self.spotifyArtists = try container.decode([SpotifyArtist].self, forKey: .spotifyArtists)
        self.availableMarkets = try container.decode([String].self, forKey: .availableMarkets)
        self.discNumber = try container.decode(Int.self, forKey: .discNumber)
        self.durationMS = try container.decode(Int.self, forKey: .durationMS)
        self.explicit = try container.decode(Bool.self, forKey: .explicit)
        self.externalIDs = try container.decode(SpotifyExternalID.self, forKey: .externalIDs)
        self.externalURLs = try container.decode(SpotifyExternalURL.self, forKey: .externalURLs)
        self.href = try container.decode(String.self, forKey: .href)
        self.spotifyId = try container.decode(String.self, forKey: .spotifyId)
        self.isPlayable = try container.decode(Bool.self, forKey: .isPlayable)
        self.linkedFrom = try container.decode(SpotifyTrackLink.self, forKey: .linkedFrom)
        self.restrictions = try container.decode(SpotifyRestriction.self, forKey: .restrictions)
        self.popularity = try container.decode(Int.self, forKey: .popularity)
        self.previewURL = try container.decode(String.self, forKey: .previewURL)
        self.trackNumber = try container.decode(Int.self, forKey: .trackNumber)
        self.type = try container.decode(String.self, forKey: .type)
        self.uri = try container.decode(String.self, forKey: .uri)
        try super.init(from: decoder)
    }
    
}
