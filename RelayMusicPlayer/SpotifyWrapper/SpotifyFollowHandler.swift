//
//  SpotifyFollowHandler.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/7/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyFollowHandler: SpotifyAPIHandler {
    
    let baseURL = "https://api.spotify.com/v1/"
    
    public enum FollowType: String {
        case artist, user
    }
    
    public func getFollowedArtists(with type: FollowType = FollowType.artist, limit: Int = 20, after: String, onSuccess: @escaping (SpotifyCursorPaging<SpotifyArtist>) -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/me/following"
        let t = type.rawValue
        url += "?type=\(t)"
        url += "&limit=\(limit)"
        url += "&after=\(after)"
        guard let followedArtistsURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: followedArtistsURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let followedArtistsObject = try jsonDecoder.decode(SpotifyCursorPaging<SpotifyArtist>.self, from:data)
                    onSuccess(followedArtistsObject)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func follow(with type: FollowType, ids: [String] = [], onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/me/following"
        let t = type.rawValue
        url += "?type=\(t)"
        guard let followURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        var data = [String:String]()
        data["ids"] = ids.joined(separator: ",")
        super.request(with: followURL, method: "PUT", data: data, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .NoContent:
                onSuccess()
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func unfollow(with type: FollowType, ids: [String] = [], onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/me/following"
        let t = type.rawValue
        url += "?type=\(t)"
        guard let unfollowURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        var data = [String:String]()
        data["ids"] = ids.joined(separator: ",")
        super.request(with: unfollowURL, method: "DELETE", data: data, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .NoContent:
                onSuccess()
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func isFollowing(with type: FollowType, ids: [String] = [], onSuccess: @escaping ([Bool]) -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/me/following/contains"
        let t = type.rawValue
        url += "?type=\(t)"
        url += "&ids=\(ids.joined(separator: ","))"
        guard let isFollowingURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
            
        }
        super.request(with: isFollowingURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let isFollowingArray = try jsonDecoder.decode([Bool].self, from:data)
                    onSuccess(isFollowingArray)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func followPlaylist(_ owner_id: String, playlist_id: String, isPublic: Bool = true, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/users/"
        url += owner_id
        url += "/playlists/"
        url += playlist_id
        url += "/followers"
        guard let followPlaylistURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        var data = [String:String]()
        data["public"] = isPublic.description
        super.request(with: followPlaylistURL, method: "PUT", data: data, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                onSuccess()
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func unfollowPlaylist(_ owner_id: String, playlist_id: String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/users/"
        url += owner_id
        url += "/playlists/"
        url += playlist_id
        url += "/followers"
        guard let unfollowPlaylistURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: unfollowPlaylistURL, method: "DELETE", onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                onSuccess()
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func isFollowingPlaylist(_ owner_id: String, playlist_id: String, ids: [String], onSuccess: @escaping ([Bool]) -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/users/"
        url += owner_id
        url += "/playlists/"
        url += playlist_id
        url += "/followers/contains"
        url += "?ids=\(ids.joined(separator: ","))"
        guard let isFollowingPlaylistURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: isFollowingPlaylistURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let isFollowingPlaylistArray = try jsonDecoder.decode([Bool].self, from:data)
                    onSuccess(isFollowingPlaylistArray)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
}
