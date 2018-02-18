//
//  SpotifyArtistsHandler.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/6/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

//NOTE: you can get a random artist with spotify's api, check the artists api page

class SpotifyArtistsHandler: SpotifyAPIHandler {
    
    let baseURL = "https://api.spotify.com/v1/artists/"
    
    public func getArtist(with id: String, onSuccess: @escaping (SpotifyArtist) -> Void, onFailure: @escaping (String) -> Void) {
        let url = baseURL + id
        guard let artistURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: artistURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let artist = try jsonDecoder.decode(SpotifyArtist.self, from:data)
                    onSuccess(artist)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func getArtists(with ids: [String], onSuccess: @escaping (SpotifyArtists) -> Void, onFailure: @escaping (String) -> Void) {
        let url = baseURL + "?ids=" + ids.joined(separator: ",")
        guard let artistsURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: artistsURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let artistsObject = try jsonDecoder.decode(SpotifyArtists.self, from:data)
                    onSuccess(artistsObject)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    enum AlbumType: String {
        case album, single, appearsOn = "appears_on", compilations
    }
    
    public func getArtistAlbums(with id: String, types: [AlbumType], limit: Int = 20, offset: Int = 0, onSuccess: @escaping (SpotifyPaging<SpotifyAlbum>) -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + id + "/albums"
        let types = types.map({ $0.rawValue }).joined(separator: ",")
        url += "?album_type=\(types)"
        url += "&limit=\(limit)"
        url += "&offset=\(offset)"
        guard let artistAlbumsURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: artistAlbumsURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let artistAlbumsPagingObject = try jsonDecoder.decode(SpotifyPaging<SpotifyAlbum>.self, from:data)
                    onSuccess(artistAlbumsPagingObject)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func getArtistTopTracks(with id: String, country: String, onSuccess: @escaping (SpotifyTracks) -> Void, onFailure: @escaping (String) -> Void) {
        let url = baseURL + id + "/top-tracks"
        guard let artistTopTracksURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: artistTopTracksURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let artistTopTracksObject = try jsonDecoder.decode(SpotifyTracks.self, from:data)
                    onSuccess(artistTopTracksObject)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func getArtistRelatedArtists(with id: String, onSuccess: @escaping (SpotifyArtists) -> Void, onFailure: @escaping (String) -> Void) {
        let url = baseURL + id + "/related-artists"
        guard let artistRelatedArtistsURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: artistRelatedArtistsURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let artistRelatedArtistsObject = try jsonDecoder.decode(SpotifyArtists.self, from:data)
                    onSuccess(artistRelatedArtistsObject)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
}
