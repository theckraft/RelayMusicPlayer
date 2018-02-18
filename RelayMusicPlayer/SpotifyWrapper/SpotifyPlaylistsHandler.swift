//
//  SpotifyPlaylistsHandler.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/7/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyPlaylistsHandler: SpotifyAPIHandler {
    
    let baseURL = "https://api.spotify.com/v1"
    
    public func getUserPlaylists(for userId: String, limit: Int = 20, offset: Int = 0, onSuccess: @escaping (SpotifyPaging<SpotifyPlaylist>) -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/users/" + userId + "/playlists"
        url += "?limit=\(limit)"
        url += "&offset=\(offset)"
        guard let userPlaylistsURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: userPlaylistsURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let userPlaylists = try jsonDecoder.decode(SpotifyPaging<SpotifyPlaylist>.self, from:data)
                    onSuccess(userPlaylists)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func getPlaylists(for userId: String, limit: Int = 20, offset: Int = 0, onSuccess: @escaping (SpotifyPaging<SpotifyPlaylist>) -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/me/playlists"
        url += "?limit=\(limit)"
        url += "&offset=\(offset)"
        guard let playlistsURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: playlistsURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let playlists = try jsonDecoder.decode(SpotifyPaging<SpotifyPlaylist>.self, from:data)
                    onSuccess(playlists)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func getPlaylist(for userId: String, playlistId: String, fields: String = "", onSuccess: @escaping (SpotifyPlaylist) -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/users/\(userId)/playlists/\(playlistId)"
        if !fields.isEmpty {
            url += "?fields=\(fields)"
        }
        guard let playlistsURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: playlistsURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let playlist = try jsonDecoder.decode(SpotifyPlaylist.self, from:data)
                    onSuccess(playlist)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func getPlaylistTracks(for userId: String, playlistId: String, fields: String = "", limit: Int = 20, offset: Int = 0, onSuccess: @escaping (SpotifyPaging<SpotifyPlaylistTrack>) -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/users/\(userId)/playlists/\(playlistId)/tracks"
        url += "?limit=\(limit)"
        url += "&offset=\(offset)"
        if !fields.isEmpty {
            url += "&fields=\(fields)"
        }
        guard let playlistsURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: playlistsURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let playlistTracks = try jsonDecoder.decode(SpotifyPaging<SpotifyPlaylistTrack>.self, from:data)
                    onSuccess(playlistTracks)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func createPlaylist(for userId: String, name: String, isPublic: Bool = true, collaborative: Bool = false, description: String?, onSuccess: @escaping (SpotifyPlaylist) -> Void, onFailure: @escaping (String) -> Void) {
        let url = baseURL + "/users/\(userId)/playlists"
        guard let createPlaylistURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        var data = [String:String]()
        data["name"] = name
        data["public"] = isPublic.description
        data["collaborative"] = collaborative.description
        if let descriptionString = description {
            data["description"] = descriptionString
        }
        super.request(with: createPlaylistURL, method: "POST", data: data, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK, .Created:
                let jsonDecoder = JSONDecoder()
                do {
                    let createdPlaylist = try jsonDecoder.decode(SpotifyPlaylist.self, from:data)
                    onSuccess(createdPlaylist)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func addTrackToPlaylist(for userId: String, playlistId: String, uris: [String]?, position: Int?, onSuccess: @escaping (SpotifySnapshot) -> Void, onFailure: @escaping (String) -> Void) {
        let url = baseURL + "/users/\(userId)/playlists/\(playlistId)/tracks"
        guard let addTracktoPlaylistURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        var data = [String:String]()
        if let urisArray = uris {
            data["uris"] = urisArray.joined(separator: ",")
        }
        if let positionInt = position {
            data["position"] = positionInt.description
        }
        super.request(with: addTracktoPlaylistURL, method: "POST", data: data, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .Created:
                let jsonDecoder = JSONDecoder()
                do {
                    let snapshot = try jsonDecoder.decode(SpotifySnapshot.self, from:data)
                    onSuccess(snapshot)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func removeTracksFromPlaylist(for userId: String, playlistId: String, tracks: [SpotifyTrack], snapshotId: String?, onSuccess: @escaping (SpotifySnapshot) -> Void, onFailure: @escaping (String) -> Void) {
        let url = baseURL + "/users/\(userId)/playlists/\(playlistId)/tracks"
        guard let removeTracksFromPlaylistURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        var data = [String:String]()
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(tracks)
        data["tracks"] = jsonData.base64EncodedString()
        if let snapshotIdString = snapshotId {
            data["snapshot_id"] = snapshotIdString
        }
        super.request(with: removeTracksFromPlaylistURL, method: "DELETE", data: data, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .Created:
                let jsonDecoder = JSONDecoder()
                do {
                    let snapshot = try jsonDecoder.decode(SpotifySnapshot.self, from:data)
                    onSuccess(snapshot)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
}
