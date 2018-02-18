//
//  SpotifySnapshot.swift
//  RelayMusicPlayer
//
//  Created by Christian Kraft on 2/18/18.
//  Copyright © 2018 Christian Kraft. All rights reserved.
//

import Foundation

class SpotifySnapshot: Codable {
    var snapshotId: String
    
    enum CodingKeys: String, CodingKey {
        case snapshotId = "snapshot_id"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.snapshotId = try container.decode(String.self, forKey: .snapshotId)
    }
}
