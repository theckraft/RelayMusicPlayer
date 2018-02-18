//
//  SpotifyLibraryHandler.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/7/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyLibraryHandler: SpotifyAPIHandler {
    
    let baseURL = "https://api.spotify.com/v1/me"
    
    public func saveTracks(_ ids: [String], onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/tracks"
        guard let saveTracksURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        var data = [String:String]()
        data["ids"] = ids.joined(separator: ",")
        super.request(with: saveTracksURL, method: "PUT", data: data, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                onSuccess()
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func getTracks(_ limit: Int = 20, offset: Int = 0, onSuccess: @escaping (SpotifyPaging<SpotifySavedTrack>) -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/tracks"
        url += "?limit=\(limit)"
        url += "&offset=\(offset)"
        guard let getTracksURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: getTracksURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let savedTracks = try jsonDecoder.decode(SpotifyPaging<SpotifySavedTrack>.self, from:data)
                    onSuccess(savedTracks)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func removeTracks(_ ids: [String], onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        let url = baseURL + "/tracks"
        guard let removeTracksURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        var data = [String:String]()
        data["ids"] = ids.joined(separator: ",")
        super.request(with: removeTracksURL, method: "DELETE", data: data, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                onSuccess()
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func checkTracks(_ ids: [String], onSuccess: @escaping ([Bool]) -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/tracks/contains"
        url += "?ids=\(ids.joined(separator: ","))"
        guard let checkTracksURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: checkTracksURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let alreadySavedArray = try jsonDecoder.decode([Bool].self, from:data)
                    onSuccess(alreadySavedArray)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func saveAlbums(_ ids: [String], onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/albums"
        guard let saveAlbumsURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        var data = [String:String]()
        data["ids"] = ids.joined(separator: ",")
        super.request(with: saveAlbumsURL, method: "PUT", data: data, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .Created:
                onSuccess()
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func getAlbums(_ limit: Int = 20, offset: Int = 0, onSuccess: @escaping (SpotifyPaging<SpotifySavedAlbum>) -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/albums"
        url += "?limit=\(limit)"
        url += "&offset=\(offset)"
        guard let getAlbumsURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: getAlbumsURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let savedAlbums = try jsonDecoder.decode(SpotifyPaging<SpotifySavedAlbum>.self, from:data)
                    onSuccess(savedAlbums)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func removeAlbums(_ ids: [String], onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        let url = baseURL + "/albums"
        guard let removeAlbumsURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        var data = [String:String]()
        data["ids"] = ids.joined(separator: ",")
        super.request(with: removeAlbumsURL, method: "DELETE", data: data, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                onSuccess()
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
    public func checkAlbums(_ ids: [String], onSuccess: @escaping ([Bool]) -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "/albums/contains"
        url += "?ids=\(ids.joined(separator: ","))"
        guard let checkAlbumsURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: checkAlbumsURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let alreadySavedArray = try jsonDecoder.decode([Bool].self, from:data)
                    onSuccess(alreadySavedArray)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
}
