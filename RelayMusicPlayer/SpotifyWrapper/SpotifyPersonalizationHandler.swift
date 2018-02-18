//
//  SpotifyPersonalizationHandler.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/7/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyPersonalizationHandler: SpotifyAPIHandler {
    
    let baseURL = "https://api.spotify.com/v1/me"
    
    public enum TimeRange: String {
        case longTerm = "long_term", mediumTerm = "medium_term", shortTerm = "short_term"
    }
    
    public enum EntityType: String {
        case artists, tracks
    }
    
    public func getTopArtists(_ limit: Int = 20, offset: Int = 0, timeRange: TimeRange, onSuccess: @escaping (SpotifyPaging<SpotifyArtist>) -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/top/artists"
        url += "?limit=\(limit)"
        url += "&offset=\(offset)"
        url += "&time_range=\(timeRange.rawValue)"
        guard let getTopArtistsURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: getTopArtistsURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let topArtists = try jsonDecoder.decode(SpotifyPaging<SpotifyArtist>.self, from:data)
                    onSuccess(topArtists)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func getTopTracks(_ limit: Int = 20, offset: Int = 0, timeRange: TimeRange, onSuccess: @escaping (SpotifyPaging<SpotifyTrack>) -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/top/tracks"
        url += "?limit=\(limit)"
        url += "&offset=\(offset)"
        url += "&time_range=\(timeRange.rawValue)"
        guard let getTopTracksURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: getTopTracksURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let topTracks = try jsonDecoder.decode(SpotifyPaging<SpotifyTrack>.self, from:data)
                    onSuccess(topTracks)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func getRecentlyPlayedTracks(_ limit: Int = 20, after: String?, before: String?, onSuccess: @escaping (SpotifyCursorPaging<SpotifyPlayHistory>) -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/player/recently-played"
        url += "?limit=\(limit)"
        if let beforeString = before {
            url += "&before=\(beforeString)"
        } else if let afterString = after {
            url += "&after=\(afterString)"
        }
        guard let getRecentlyPlayedTracksURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: getRecentlyPlayedTracksURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let recentlyPlayedTracks = try jsonDecoder.decode(SpotifyCursorPaging<SpotifyPlayHistory>.self, from:data)
                    onSuccess(recentlyPlayedTracks)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    
    
}
