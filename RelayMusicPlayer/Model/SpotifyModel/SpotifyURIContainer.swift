//
//  SpotifyURIContainer.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/18/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyURIContainer: Codable {
    var uri: String
    
    init(uri: String) {
        self.uri = uri
    }
    
    enum CodingKeys: String, CodingKey {
        case uri
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uri = try container.decode(String.self, forKey: .uri)
    }
}
