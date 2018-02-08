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
    
    public func getArtist(with id: String, onSuccess: @escaping (SpotifyArtist) -> Void, onFailure: @escaping () -> Void) {
        let url = baseURL + id
        guard let artistURL = URL(string: url) else {
            onFailure()
            return
        }
        super.request(with: artistURL, onSuccess: { data in
            let jsonDecoder = JSONDecoder()
            do {
                let artist = try jsonDecoder.decode(SpotifyArtist.self, from:data)
                onSuccess(artist)
            } catch {
                print("caught: \(error)")
                onFailure()
            }
        }, onFailure: { onFailure() })
    }
    public func getArtists(with ids: [String], onSuccess: @escaping ([SpotifyArtist]) -> Void, onFailure: @escaping () -> Void) {
        let url = baseURL + "?ids=" + ids.joined(separator: ",")
        guard let artistsURL = URL(string: url) else {
            onFailure()
            return
        }
        super.request(with: artistsURL, onSuccess: { data in
            let jsonDecoder = JSONDecoder()
            do {
                //may not work, does not match the example BUT it makes sense and probably will work
                let artists = try jsonDecoder.decode([SpotifyArtist].self, from:data)
                onSuccess(artists)
            } catch {
                print("caught: \(error)")
                onFailure()
            }
        }, onFailure: { onFailure() })
    }
    
    enum AlbumType: String {
        case album, single, appearsOn = "appears_on", compilations
    }
    
    public func getArtistAlbums(with id: String, types: [AlbumType], limit: Int = 20, offset: Int = 0, onSuccess: @escaping (SpotifyPaging<SpotifyAlbum>) -> Void, onFailure: @escaping () -> Void) {
        var url = baseURL + id + "/albums"
        let types = types.map({ $0.rawValue }).joined(separator: ",")
        url += "?album_type=\(types)"
        url += "&limit=\(limit)"
        url += "&offset=\(offset)"
        guard let artistAlbumsURL = URL(string: url) else {
            onFailure()
            return
        }
        super.request(with: artistAlbumsURL, onSuccess: { data in
            let jsonDecoder = JSONDecoder()
            do {
                let artistAlbumsPagingObject = try jsonDecoder.decode(SpotifyPaging<SpotifyAlbum>.self, from:data)
                onSuccess(artistAlbumsPagingObject)
            } catch {
                print("caught: \(error)")
                onFailure()
            }
        }, onFailure: { onFailure() })
    }
    public func getArtistTopTracks(with id: String, country: String, onSuccess: @escaping (SpotifyTracks) -> Void, onFailure: @escaping () -> Void) {
        
    }
}
