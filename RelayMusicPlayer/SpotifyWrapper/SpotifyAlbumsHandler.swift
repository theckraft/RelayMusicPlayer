//
//  SpotifyAlbumsHandler.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/6/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyAlbumsHandler: SpotifyAPIHandler {
    
    let baseURL = "https://api.spotify.com/v1/albums/"
    
    //get album with id
    public func getAlbum(with id: String, onSuccess: @escaping (SpotifyAlbum) -> Void, onFailure: @escaping () -> Void) {
        //full url with album id
        let url = baseURL + id
        //create URL
        guard let albumURL = URL(string: url) else {
            onFailure()
            return
        }
        //handle results, callback will run after request is made
        super.request(with: albumURL, onSuccess: { data in
            let jsonDecoder = JSONDecoder()
            do {
                let album = try jsonDecoder.decode(SpotifyAlbum.self, from:data)
                onSuccess(album)
            } catch {
                print("caught: \(error)")
                onFailure()
            }
        }, onFailure: { onFailure() })
    }
    //get albums with ids
    public func getAlbums(with ids: [String], onSuccess: @escaping (SpotifyAlbums) -> Void, onFailure: @escaping () -> Void) {
        //full url with ids, comma delimited
        let url = baseURL + "?ids=" + ids.joined(separator: ",")
        //create URL
        guard let albumsURL = URL(string: url) else {
            onFailure()
            return
        }
        super.request(with: albumsURL, onSuccess: { data in
            let jsonDecoder = JSONDecoder()
            do {
                let albumsObject = try jsonDecoder.decode(SpotifyAlbums.self, from:data)
                onSuccess(albumsObject)
            } catch {
                print("caught: \(error)")
                onFailure()
            }
        }, onFailure: { onFailure() })
    }
    //get album's tracks
    public func getAlbumTracks(with id: String, limit: Int = 20, offset: Int = 0, onSuccess: @escaping (SpotifyPaging<SpotifyTrack>) -> Void, onFailure: @escaping () -> Void) {
        var url = baseURL + id + "/tracks"
        url += "?limit=" + String(limit)
        url += "&offset=" + String(offset)
        guard let albumTracksURL = URL(string: url) else {
            onFailure()
            return
        }
        super.request(with: albumTracksURL, onSuccess: { data in
            let jsonDecoder = JSONDecoder()
            do {
                let albumTracksPagingObject = try jsonDecoder.decode(SpotifyPaging<SpotifyTrack>.self, from:data)
                onSuccess(albumTracksPagingObject)
            } catch {
                print("caught: \(error)")
                onFailure()
            }
        }, onFailure: { onFailure() })
    }
}
