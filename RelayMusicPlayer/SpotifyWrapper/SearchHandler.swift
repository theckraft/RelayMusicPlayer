//
//  SearchHandler.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 9/28/17.
//  Copyright © 2017 Christian Kraft. All rights reserved.
//

import Foundation

class SearchHandler: APIHandler {
    
    enum SearchType: String {
        case album, artist, playlist, track
    }
    
    func search(with query: String, types: [SearchType] ){
        
        var url = "https://api.spotify.com/v1/search"
        
        let q = query.split(separator: " ").map { String($0) }.joined(separator: "+")
        url += "?q=\(q)"
        
        let t = types.map({ $0.rawValue }).joined(separator: ",")
        url += "&type=\(t)"
        
        guard let searchURL = URL(string: url) else {
            return
        }
        
        super.request(with: searchURL, callback: { resultingDict in
            //do something with the results
            //consider creating classes that parse the dictionaries before handing them back here
            //OR do that parsing right now (by calling other methods)
            //PROBABLY the latter, since we have the search types with us already
            //we don't need to include them in our request
        })
    }
    
}
