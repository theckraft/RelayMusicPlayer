//
//  SearchHandler.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 9/28/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifySearchHandler: SpotifyAPIHandler {
    
    // From Spotify Documentation
    //    Field filters
    //    By default, results are returned when a match is found in any field of the target object type.
    //    Searches can be made more specific by specifying an album, artist or track field filter.
    //    For example, the query q=album:gold%20artist:abba&type=album will only return albums with the text "gold" in the album name and the text "abba" in the artist's name.
    // ** This may be useful later on. I doubt many spotify users know about these features. They can currently use them just by typing them, though we may need to use them somewhere other than the search (or make these features more obvious in the search)
    
    public enum SearchType: String {
        case album, artist, playlist, track
    }
    
    //search function for any spotify search
    //TODO: add functionality for other search parameters (check api)
    public func search(with query: String, types: [SearchType], onSuccess: @escaping (SpotifySearch) -> Void, onFailure: @escaping () -> Void) {
        
        //spotify search url (domain should be stored in a constants file)
        var url = "https://api.spotify.com/v1/search"
        
        //search query string
        let q = query.split(separator: " ").map { String($0) }.joined(separator: "+")
        url += "?q=\(q)"
        
        //requested types (album, artist, playlist, track)
        let t = types.map({ $0.rawValue }).joined(separator: ",")
        url += "&type=\(t)"
        
        //TODO: add from_token -- do we have access to the token here?
        url += "&from_token=\(String(session.accessToken))"
        
        //create URL
        guard let searchURL = URL(string: url) else {
            return
        }
        
        //handle results, callback will run after request is made
        super.request(with: searchURL, onSuccess: { data in
            
            let jsonDecoder = JSONDecoder()
            do {
                let spotifySearchObject = try jsonDecoder.decode(SpotifySearch.self, from:data)
                onSuccess(spotifySearchObject)
            } catch {
                print("caught: \(error)")
                onFailure()
            }
        }, onFailure: {
            onFailure()
        })
    }
    
}

