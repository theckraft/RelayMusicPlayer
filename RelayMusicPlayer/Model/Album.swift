//
//  Album.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 1/13/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class Album: BaseEntity {
    
    var name: String
    
    //TODO - remove songs array from Artists
    //create computed variable instead that takes from albums
    //all logic should and can be through albums
    var songs: [Song] = []
    var artists: [Artist] = []
    //TODO - consider featuring artists in songs
    //in album, act as if each artist had equal part in album
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    private enum CodingKeys: String, CodingKey {
        case name, songs, artists
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.songs = try container.decode([Song].self, forKey: .songs)
        self.artists = try container.decode([Artist].self, forKey: .artists)
        try super.init(from: decoder)
    }
    
}
