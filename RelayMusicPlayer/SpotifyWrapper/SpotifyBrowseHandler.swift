//
//  SpotifyBrowseHandler.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/7/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

//NOTE: there's a getRecommendations endpoint that might only be in spotify's browse section of the api guides. this will be useful

class SpotifyBrowseHandler: SpotifyAPIHandler {
    
    let baseURL = "https://api.spotify.com/v1/browse/"
    
    public func getFeaturedPlaylists(with limit: Int = 20, offset: Int = 0, onSuccess: @escaping (SpotifyPlaylistsComposite) -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "featured-playlists"
        url += "?limit=\(limit)"
        url += "&offset=\(offset)"
        guard let featuredPlaylistsURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: featuredPlaylistsURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let playlistsObject = try jsonDecoder.decode(SpotifyPlaylistsComposite.self, from:data)
                    onSuccess(playlistsObject)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error") }
        }, onFailure: { message in onFailure(message) })
    }
    public func getNewReleases(with limit: Int = 20, offset: Int = 0, onSuccess: @escaping (SpotifyAlbumsComposite) -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "new-releases"
        url += "?limit=\(limit)"
        url += "&offset=\(offset)"
        guard let newReleasesURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: newReleasesURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let albumsObject = try jsonDecoder.decode(SpotifyAlbumsComposite.self, from:data)
                    onSuccess(albumsObject)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    public func getCategories(with limit: Int = 20, offset: Int = 0, onSuccess: @escaping (SpotifyPaging<SpotifyCategory>) -> Void, onFailure: @escaping (String) -> Void) {
        var url = baseURL + "categories"
        url += "?limit=\(limit)"
        url += "&offset=\(offset)"
        guard let categoriesURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: categoriesURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let categoriesObject = try jsonDecoder.decode(SpotifyPaging<SpotifyCategory>.self, from:data)
                    onSuccess(categoriesObject)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    public func getCategory(with id: String, onSuccess: @escaping (SpotifyCategory) -> Void, onFailure: @escaping (String) -> Void) {
        let url = baseURL + "categories/" + id
        guard let categoryURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: categoryURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let categoryObject = try jsonDecoder.decode(SpotifyCategory.self, from:data)
                    onSuccess(categoryObject)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    public func getCategoryPlaylists(with id: String, limit: Int = 20, offset: Int = 0, onSuccess: @escaping (SpotifyPaging<SpotifyPlaylist>) -> Void, onFailure: @escaping (String) -> Void) {
        let url = baseURL + "categories/" + id + "/playlists"
        guard let categoryPlaylistsURL = URL(string: url) else {
            onFailure("Could Not Generate URL.")
            return
        }
        super.request(with: categoryPlaylistsURL, onSuccess: { (data, statusCode) in
            switch statusCode {
            case .OK:
                let jsonDecoder = JSONDecoder()
                do {
                    let categoryPlaylistsObject = try jsonDecoder.decode(SpotifyPaging<SpotifyPlaylist>.self, from:data)
                    onSuccess(categoryPlaylistsObject)
                } catch { onFailure("Could Not Decode Data") }
            default:
                onFailure("Unidentified Error")
            }
        }, onFailure: { message in onFailure(message) })
    }
    
}
