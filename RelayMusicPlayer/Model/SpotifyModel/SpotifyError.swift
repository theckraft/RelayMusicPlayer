//
//  SpotifyError.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/8/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyError: Codable {
    var status: Int
    var message: String
    
    init(status: Int, message: String) {
        self.status = status
        self.message = message
    }
    
    enum CodingKeys: String, CodingKey {
        case status
        case message
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decode(Int.self, forKey: .status)
        self.message = try container.decode(String.self, forKey: .message)
    }
}
