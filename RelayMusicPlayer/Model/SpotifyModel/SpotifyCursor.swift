//
//  SpotifyCursor.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/8/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifyCursor: Codable {
    var next: String
    
    enum CodingKeys: String, CodingKey {
        case next
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.next = try container.decode(String.self, forKey: .next)
    }
    
}
